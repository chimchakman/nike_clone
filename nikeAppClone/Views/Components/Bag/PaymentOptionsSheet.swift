//
//  PaymentOptionsSheet.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/7/26.
//

import SwiftUI

struct PaymentOptionsSheet: View {
    @Environment(\.dismiss) var dismiss
    var onPaymentSelected: ((PaymentCard) -> Void)?

    @State private var selectedCard: PaymentCard? = PaymentCard(
        cardNumber: "1365555555555383",
        cardholderName: "John Smith",
        expiryDate: "12/25",
        cvv: "123",
        cardType: .mastercard
    )
    @State private var showAddCardSheet = false
    @State private var isSaving = false
    @State private var showErrorAlert = false
    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Payment")
                    .font(.system(size: 16, weight: .medium))
                    .tracking(-0.4)

                Spacer()

                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "minus")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.black)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
            .background(Color.white)

            Divider()

            // Payment Card Display
            if let card = selectedCard {
                HStack(spacing: 22) {
                    // Checkmark
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(.black)

                    // Card Icon and Number
                    HStack(spacing: 8) {
                        // Card Logo
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.lightGray87, lineWidth: 1)
                                .frame(width: 72, height: 48)
                                .background(Color.white)
                                .cornerRadius(4)

                            // Mastercard Logo
                            HStack(spacing: -8) {
                                Circle()
                                    .fill(Color.cardRed)
                                    .frame(width: 20, height: 20)

                                Circle()
                                    .fill(Color.cardOrange)
                                    .frame(width: 20, height: 20)
                            }
                        }

                        Text(card.maskedCardNumber)
                            .font(.system(size: 14, weight: .regular))
                            .tracking(-0.14)
                            .foregroundStyle(.black)
                    }

                    Spacer()

                    // Edit Button
                    Button(action: {
                        // TODO: Handle edit card
                    }) {
                        Text("Edit")
                            .font(.system(size: 12))
                            .tracking(-0.3)
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 24)

                Divider()
            }

            Spacer()

            // Bottom Buttons
            VStack(spacing: 14) {
                Button(action: {
                    Task {
                        await saveAndContinue()
                    }
                }) {
                    Text(isSaving ? "Saving..." : "Continue")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(isSaving ? Color.gray : Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 100))
                }
                .disabled(isSaving || selectedCard == nil)

                Button(action: {
                    showAddCardSheet = true
                }) {
                    Text("Add Card")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(Color.lightGray90, lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)

            // Home Indicator
            Color.clear
                .frame(height: 33)
                .overlay(
                    Capsule()
                        .fill(Color.black)
                        .frame(width: 135, height: 5)
                        .padding(.bottom, 8),
                    alignment: .bottom
                )
        }
        .background(Color.white)
        .sheet(isPresented: $showAddCardSheet) {
            // TODO: Add card form sheet
            Text("Add Card Form")
        }
        .alert("Error", isPresented: $showErrorAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }

    // MARK: - Save and Continue

    private func saveAndContinue() async {
        guard let card = selectedCard else { return }

        isSaving = true

        do {
            var cardToSave = card

            // If card doesn't have an ID, save it to Supabase first
            if card.id == nil {
                // Get current user ID
                let userId = try await AuthService.shared.getCurrentUser()

                // Save to Supabase and get back the card with ID
                cardToSave = try await PaymentCardService.shared.savePaymentCard(userId: userId, card: card)
            }

            // Success
            await MainActor.run {
                onPaymentSelected?(cardToSave)
                dismiss()
            }

        } catch {
            // Handle error
            await MainActor.run {
                isSaving = false
                errorMessage = error.localizedDescription
                showErrorAlert = true
            }
        }
    }
}

#Preview {
    PaymentOptionsSheet()
}
