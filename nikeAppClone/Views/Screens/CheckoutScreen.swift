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
    @State private var showDeliveryOptions = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        // Product Header
                        if let firstItem = bagStore.items.first {
                            let product = Products.getOne(id: firstItem.productId)

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
                                actionText: "Select Delivery",
                                actionColor: .red,
                                onTap: {
                                    showDeliveryOptions = true
                                }
                            )

                            CheckoutExpandableRow(
                                title: "Payment",
                                actionText: "Select Payment",
                                actionColor: .red,
                                onTap: {
                                    // TODO: Show payment options
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

                    RoundedButton(
                        "Submit Payment",
                        theme: .black,
                        style: .outline,
                        action: {
                            // TODO: Handle payment submission
                            dismiss()
                        }
                    )
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                }
                .background(Color.white)
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showDeliveryOptions) {
                DeliveryOptionsSheet()
                    .presentationDetents([.fraction(0.75), .large])
                    .presentationDragIndicator(.visible)
            }
        }
    }

    // MARK: - Price Calculation

    private var formattedTotal: String {
        let total = bagStore.items.reduce(0.0) { sum, item in
            let product = Products.getOne(id: item.productId)
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
}
