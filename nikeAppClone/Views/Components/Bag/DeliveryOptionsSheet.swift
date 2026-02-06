//
//  DeliveryOptionsSheet.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/7/26.
//

import SwiftUI

struct DeliveryOptionsSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedOption: DeliveryOption = .freeDelivery

    enum DeliveryOption {
        case freeDelivery
        case pickup
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    HStack {
                        Text("Delivery")
                            .font(.system(size: 20, weight: .semibold))

                        Spacer()

                        Image(systemName: "minus")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.black)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    .padding(.bottom, 24)

                    Divider()

                    // Delivery Options
                    VStack(spacing: 0) {
                        deliveryOptionRow(
                            option: .freeDelivery,
                            title: "Free Delivery",
                            subtitle: "Arrives Wed, 11 May to Fri, 13 May",
                            isSelected: selectedOption == .freeDelivery
                        )

                        deliveryOptionRow(
                            option: .pickup,
                            title: "Pick-Up",
                            subtitle: "Find a Location",
                            isSelected: selectedOption == .pickup
                        )
                    }

                    Divider()

                    // Delivery Details Section
                    Text("Delivery Details")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal, 24)
                        .padding(.top, 24)
                        .padding(.bottom, 16)

                    // Enter Delivery Address
                    HStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 16))
                            .foregroundStyle(.red)

                        Text("Enter Delivery Address")
                            .font(.system(size: 16))
                            .foregroundStyle(.red)

                        Spacer()

                        Text("Edit")
                            .font(.system(size: 16))
                            .foregroundStyle(.black)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
                }
            }

            // Bottom Buttons
            VStack(spacing: 12) {
                Divider()

                RoundedButton(
                    "Continue",
                    theme: .black,
                    style: .solid,
                    action: {
                        dismiss()
                    }
                )
                .padding(.horizontal, 24)

                RoundedButton(
                    "Add Address",
                    theme: .white,
                    style: .outline,
                    action: {
                        // TODO: Handle add address
                    }
                )
                .padding(.horizontal, 24)
                .padding(.bottom, 12)
            }
            .background(Color.white)
        }
    }

    // MARK: - Delivery Option Row

    private func deliveryOptionRow(
        option: DeliveryOption,
        title: String,
        subtitle: String,
        isSelected: Bool
    ) -> some View {
        VStack(spacing: 0) {
            Button(action: {
                selectedOption = option
            }) {
                HStack(alignment: .top, spacing: 12) {
                    // Radio Button
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                        .font(.system(size: 20))
                        .foregroundStyle(isSelected ? .black : .gray.opacity(0.3))

                    // Content
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.black)

                        HStack(spacing: 4) {
                            Text(subtitle)
                                .font(.system(size: 14))
                                .foregroundStyle(.secondary)

                            Text("More Options")
                                .font(.system(size: 14))
                                .underline()
                                .foregroundStyle(.secondary)
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    DeliveryOptionsSheet()
}
