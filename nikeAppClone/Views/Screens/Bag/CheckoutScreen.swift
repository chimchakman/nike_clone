//
//  CheckoutScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/6/26.
//

import SwiftUI

struct CheckoutScreen: View {
    @Environment(\.dismiss) var dismiss
    @Environment(BagStore.self) var bagStore: BagStore
    @Environment(Products.self) var products: Products
    @State private var showDeliveryOptions = false
    @State private var deliveryAddress: Address? = nil
    @State private var showPaymentOptions = false
    @State private var selectedPaymentCard: PaymentCard? = nil
    @State private var showPaymentSuccess = false
    @State private var showOrderConfirmation = false

    private var isCheckoutReady: Bool {
        deliveryAddress != nil && selectedPaymentCard != nil
    }

    var body: some View {
        ZStack {
            NavigationView {
                VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        // Product Header
                        if let firstItem = bagStore.items.first {
                            let product = products.getOne(id: firstItem.productId)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(product.name)
                                    .font(.system(size: 20, weight: .semibold))

                                Text(product.colors)
                                    .font(.system(size: 14))
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.horizontal, 24)
                            .padding(.top, 24)
                            .padding(.bottom, 32)
                        }

                        Divider()

                        // Expandable Sections
                        VStack(spacing: 0) {
                            CheckoutExpandableRow(
                                title: "Delivery",
                                actionText: deliveryAddress != nil ? "Free Delivery" : "Select Delivery",
                                actionColor: deliveryAddress != nil ? .secondary : .red,
                                subtitle: deliveryAddress != nil ? "Arrives by Tue, 10 May" : nil,
                                onTap: {
                                    showDeliveryOptions = true
                                }
                            )

                            CheckoutExpandableRow(
                                title: "Payment",
                                actionText: selectedPaymentCard != nil ? selectedPaymentCard!.maskedCardNumber : "Select Payment",
                                actionColor: selectedPaymentCard != nil ? .black : .red,
                                onTap: {
                                    showPaymentOptions = true
                                }
                            )

                            CheckoutExpandableRow(
                                title: "Purchase Summary",
                                actionText: formattedTotal,
                                actionColor: .black,
                                onTap: {
                                    // TODO: Show purchase summary details
                                }
                            )
                        }
                        .padding(.horizontal, 24)

                        // Terms of Sale
                        HStack(alignment: .top, spacing: 4) {
                            Text("By tapping 'Submit Payment', I agree to the")
                                .font(.system(size: 12))
                                .foregroundStyle(.secondary)
                            Text("Terms of Sale")
                                .font(.system(size: 12))
                                .underline()
                                .foregroundStyle(.secondary)
                            Text(".")
                                .font(.system(size: 12))
                                .foregroundStyle(.secondary)
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 24)
                    }
                }

                // Submit Payment Button
                VStack(spacing: 0) {
                    Divider()

                    Button(action: {
                        if isCheckoutReady {
                            showPaymentSuccess = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                showPaymentSuccess = false
                                showOrderConfirmation = true
                            }
                        }
                    }) {
                        Text("Submit Payment")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(isCheckoutReady ? .white : Color(white: 0.46))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(isCheckoutReady ? Color.black : Color(white: 0.96))
                            .clipShape(RoundedRectangle(cornerRadius: 100))
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(isCheckoutReady ? Color.black : Color(white: 0.96), lineWidth: 1)
                            )
                    }
                    .disabled(!isCheckoutReady)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                }
                .background(Color.white)
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .sheet(isPresented: $showDeliveryOptions) {
                DeliveryOptionsSheet(
                    onAddressSelected: { address in
                        deliveryAddress = address
                    }
                )
                .presentationDetents([.fraction(0.75), .large])
                .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $showPaymentOptions) {
                PaymentOptionsSheet(
                    onPaymentSelected: { card in
                        selectedPaymentCard = card
                    }
                )
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
            }
            .fullScreenCover(isPresented: $showOrderConfirmation) {
                if let address = deliveryAddress, let card = selectedPaymentCard {
                    OrderConfirmationScreen(
                        deliveryAddress: address,
                        paymentCard: card
                    )
                    .environment(bagStore)
                    .environment(products)
                }
            }

            // Payment Success Overlay with Custom Transition
            if showPaymentSuccess {
                PaymentSuccessView()
                    .transition(.scale.combined(with: .opacity))
                    .zIndex(1)
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: showPaymentSuccess)
    }

    // MARK: - Price Calculation

    private var formattedTotal: String {
        let total = bagStore.items.reduce(0.0) { sum, item in
            let product = products.getOne(id: item.productId)
            return sum + (parsePrice(product.price) * Double(item.quantity))
        }
        return String(format: "US$%.2f", total)
    }

    private func parsePrice(_ priceString: String) -> Double {
        let cleaned = priceString
            .replacingOccurrences(of: "US$", with: "")
            .replacingOccurrences(of: ",", with: "")
        return Double(cleaned) ?? 0
    }
}

#Preview {
    CheckoutScreen()
        .environment(BagStore())
        .environment(Products())
}
