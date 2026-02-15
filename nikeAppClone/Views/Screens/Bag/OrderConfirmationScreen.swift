//
//  OrderConfirmationScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/7/26.
//

import SwiftUI

struct OrderConfirmationScreen: View {
    @Environment(\.dismiss) var dismiss
    @Environment(BagStore.self) var bagStore: BagStore
    @Environment(ProductsViewModel.self) var products: ProductsViewModel

    var deliveryAddress: Address
    var paymentCard: PaymentCard

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Header with Close Button
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Thank You")
                                .font(.system(size: 28, weight: .medium))
                                .tracking(-0.168)

                            Text("For Your Order")
                                .font(.system(size: 28, weight: .medium))
                                .tracking(-0.168)
                        }

                        Spacer()

                        Button(action: {
                            dismiss()
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 40, height: 40)

                                Image(systemName: "xmark")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    .padding(.bottom, 16)

                    // Confirmation Message
                    Text("We've emailed you a confirmation to")
                        .font(.system(size: 14))
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 24)

                    Text("john@mail.com")
                        .font(.system(size: 14, weight: .medium))
                        .padding(.horizontal, 24)

                    Text("and we'll notify you when your order has been dispatched.")
                        .font(.system(size: 14))
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 32)

                    Divider()

                    // Delivery Info
                    HStack(alignment: .top) {
                        Text("Delivery")
                            .font(.system(size: 16, weight: .semibold))

                        Spacer()

                        VStack(alignment: .trailing, spacing: 4) {
                            Text(deliveryAddress.fullName)
                                .font(.system(size: 14))
                                .foregroundStyle(.secondary)

                            Text(deliveryAddress.addressLine1)
                                .font(.system(size: 14))
                                .foregroundStyle(.secondary)

                            Text("\(deliveryAddress.postalCode), \(deliveryAddress.city), US")
                                .font(.system(size: 14))
                                .foregroundStyle(.secondary)

                            Text("john@mail.com")
                                .font(.system(size: 14))
                                .foregroundStyle(.secondary)
                        }
                        .multilineTextAlignment(.trailing)
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)

                    Divider()

                    // Purchase Number
                    HStack {
                        Text("Purchase Number")
                            .font(.system(size: 16, weight: .semibold))

                        Spacer()

                        Text("C19283791823")
                            .font(.system(size: 14))
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)

                    Divider()

                    // Payment Info
                    HStack {
                        Text("Payment")
                            .font(.system(size: 16, weight: .semibold))

                        Spacer()

                        HStack(spacing: 8) {
                            Text(paymentCard.maskedCardNumber)
                                .font(.system(size: 14))
                                .foregroundStyle(.secondary)

                            // Mastercard Logo
                            HStack(spacing: -4) {
                                Circle()
                                    .fill(Color.cardRed)
                                    .frame(width: 16, height: 16)

                                Circle()
                                    .fill(Color.cardOrange)
                                    .frame(width: 16, height: 16)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)

                    Divider()

                    // Pricing Summary
                    VStack(spacing: 8) {
                        HStack {
                            Text("Subtotal")
                                .font(.system(size: 14))
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text(formattedSubtotal)
                                .font(.system(size: 14))
                                .foregroundStyle(.secondary)
                        }

                        HStack {
                            Text("Delivery")
                                .font(.system(size: 14))
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text("US$0.00")
                                .font(.system(size: 14))
                                .foregroundStyle(.secondary)
                        }

                        HStack {
                            Text("Tax")
                                .font(.system(size: 14))
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text("US$0.00")
                                .font(.system(size: 14))
                                .foregroundStyle(.secondary)
                        }

                        HStack {
                            Text("Total")
                                .font(.system(size: 16, weight: .semibold))
                            Spacer()
                            Text(formattedSubtotal)
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)

                    Divider()

                    // Item Section
                    Text("Item")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal, 24)
                        .padding(.top, 16)
                        .padding(.bottom, 12)

                    // Product Item
                    if let firstItem = bagStore.items.first {
                        let product = products.getOne(id: firstItem.productId)

                        HStack(spacing: 16) {
                            // Product Image
                            Image(product.imageUrl)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 8))

                            // Product Info
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Arrives by Tue, 10 May")
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color.successGreen)

                                Text(product.name)
                                    .font(.system(size: 14, weight: .medium))

                                Text("US$\(NSDecimalNumber(decimal: product.price).doubleValue, specifier: "%.2f")")
                                    .font(.system(size: 14, weight: .medium))

                                Text(product.colors)
                                    .font(.system(size: 12))
                                    .foregroundStyle(.secondary)

                                Text("Size L (W 10-13 / M 8-12)")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.secondary)

                                Spacer()
                            }

                            Spacer()
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                    }
                }
            }

            // Bottom Buttons
            VStack(spacing: 12) {
                Button(action: {
                    // TODO: View or manage order
                }) {
                    Text("View or Manage Order")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 100))
                }

                Button(action: {
                    // TODO: Save receipt
                }) {
                    Text("Save Receipt")
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
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(Color.white)

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
    }

    // MARK: - Price Calculation

    private var formattedSubtotal: String {
        let total = bagStore.items.reduce(0.0) { sum, item in
            let product = products.getOne(id: item.productId)
            let unitPrice = NSDecimalNumber(decimal: product.price).doubleValue
            return sum + (unitPrice * Double(item.quantity))
        }
        return String(format: "US$%.2f", total)
    }
}

#Preview {
    OrderConfirmationScreen(
        deliveryAddress: Address(
            firstName: "John",
            lastName: "Smith",
            addressLine1: "2950 S 108th St",
            addressLine2: "",
            postalCode: "53227",
            city: "West Allis",
            country: "United States",
            phoneNumber: "652-858-0392"
        ),
        paymentCard: PaymentCard(
            cardNumber: "1365555555555383",
            cardholderName: "John Smith",
            expiryDate: "12/25",
            cvv: "123",
            cardType: .mastercard
        )
    )
    .environment(BagStore())
    .environment(ProductsViewModel())
}
