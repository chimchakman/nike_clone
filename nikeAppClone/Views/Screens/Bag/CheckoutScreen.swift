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
    @Environment(ProductsViewModel.self) var products: ProductsViewModel
    @State private var showDeliveryOptions = false
    @State private var deliveryAddress: Address? = nil
    @State private var showPaymentOptions = false
    @State private var selectedPaymentCard: PaymentCard? = nil
    @State private var showPaymentSuccess = false
    @State private var showOrderConfirmation = false
    @State private var createdOrder: Order? = nil
    @State private var isProcessingPayment = false
    @State private var showErrorAlert = false
    @State private var errorMessage = ""

    private var isCheckoutReady: Bool {
        deliveryAddress != nil && selectedPaymentCard != nil && !isProcessingPayment
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
                        Task {
                            await submitPayment()
                        }
                    }) {
                        Text("Submit Payment")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(isCheckoutReady ? .white : Color.mediumGray)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(isCheckoutReady ? Color.black : Color.lightGray96)
                            .clipShape(RoundedRectangle(cornerRadius: 100))
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(isCheckoutReady ? Color.black : Color.lightGray96, lineWidth: 1)
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
                if let order = createdOrder, let address = deliveryAddress, let card = selectedPaymentCard {
                    OrderConfirmationScreen(
                        order: order,
                        deliveryAddress: address,
                        paymentCard: card
                    )
                    .environment(bagStore)
                    .environment(products)
                }
            }
            .alert("Payment Failed", isPresented: $showErrorAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
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
            let unitPrice = NSDecimalNumber(decimal: product.price).doubleValue
            return sum + (unitPrice * Double(item.quantity))
        }
        return String(format: "US$%.2f", total)
    }

    // MARK: - Submit Payment

    private func submitPayment() async {
        guard let address = deliveryAddress, let card = selectedPaymentCard else {
            return
        }

        guard !bagStore.items.isEmpty else {
            errorMessage = "Your cart is empty."
            showErrorAlert = true
            return
        }

        isProcessingPayment = true
        showPaymentSuccess = true

        do {
            // Get current user ID
            let userId = try await AuthService.shared.getCurrentUser().uuidString

            // Validate address and card IDs
            guard let addressId = address.id, let cardId = card.id else {
                throw OrderError.invalidData
            }

            // Prepare order items from bag
            var orderItems: [OrderItemCreate] = []
            for bagItem in bagStore.items {
                let product = products.getOne(id: bagItem.productId)
                orderItems.append(OrderItemCreate(
                    productId: bagItem.productId,
                    size: bagItem.size,
                    quantity: bagItem.quantity,
                    priceAtPurchase: product.price
                ))
            }

            // Calculate total amount
            let totalAmount = bagStore.items.reduce(Decimal(0)) { sum, item in
                let product = products.getOne(id: item.productId)
                return sum + (product.price * Decimal(item.quantity))
            }

            // Create order
            let order = try await OrderService.shared.createOrder(
                userId: userId,
                addressId: addressId,
                paymentCardId: cardId,
                items: orderItems,
                totalAmount: totalAmount
            )

            // Wait for animation
            try await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 seconds

            // Success
            await MainActor.run {
                createdOrder = order
                showPaymentSuccess = false
                showOrderConfirmation = true
                isProcessingPayment = false
            }

        } catch {
            // Handle error
            await MainActor.run {
                showPaymentSuccess = false
                isProcessingPayment = false
                errorMessage = error.localizedDescription
                showErrorAlert = true
            }
        }
    }
}

#Preview {
    CheckoutScreen()
        .environment(BagStore())
        .environment(ProductsViewModel())
}
