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
                                .stroke(Color(white: 0.87), lineWidth: 1)
                                .frame(width: 72, height: 48)
                                .background(Color.white)
                                .cornerRadius(4)

                            // Mastercard Logo
                            HStack(spacing: -8) {
                                Circle()
                                    .fill(Color(red: 0.92, green: 0.15, blue: 0.15))
                                    .frame(width: 20, height: 20)

                                Circle()
                                    .fill(Color(red: 0.98, green: 0.56, blue: 0.09))
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
                    if let card = selectedCard {
                        onPaymentSelected?(card)
                    }
                    dismiss()
                }) {
                    Text("Continue")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 100))
                }

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
                                .stroke(Color(white: 0.9), lineWidth: 1)
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
    }
}

#Preview {
    PaymentOptionsSheet()
}
