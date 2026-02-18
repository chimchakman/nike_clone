//
//  bagScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/27/26.
//

import SwiftUI

struct BagScreen: View {
    @Environment(BagStore.self) var bagStore: BagStore
    @Environment(ProductsViewModel.self) var products: ProductsViewModel
    @State private var showCheckout = false

    var body: some View {
        VStack(spacing: 0) {
            if bagStore.isEmpty {
                emptyBagView
            } else {
                filledBagView
            }
        }
        .task {
            // Load products for all items in bag
            for item in bagStore.items {
                await products.loadProduct(id: item.productId)
            }
        }
    }

    // MARK: - Empty State

    private var emptyBagView: some View {
        VStack(spacing: 16) {
            Text("Bag")
                .font(.system(size: 36, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 44)

            Spacer()

            Text("Your bag is empty.")
                .font(.system(size: 18))
                .foregroundStyle(.secondary)

            Spacer()
        }
    }

    // MARK: - Filled Bag

    private var filledBagView: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Bag")
                        .font(.system(size: 36, weight: .medium))
                        .padding(.horizontal, 24)
                        .padding(.top, 24)
                        .padding(.bottom, 20)

                    bannerCard
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)

                    ForEach(bagStore.items) { item in
                        let product = products.getOne(id: item.productId)
                        BagItemRow(
                            bagItem: item,
                            product: product,
                            onQuantityChange: { newQty in
                                if newQty <= 0 {
                                    bagStore.remove(itemId: item.id)
                                } else {
                                    bagStore.updateQuantity(
                                        itemId: item.id, quantity: newQty
                                    )
                                }
                            }
                        )
                        .padding(.horizontal, 24)
                    }

                    promoCodeSection
                        .padding(.horizontal, 24)

                    summarySection
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
                }
            }

            VStack(spacing: 0) {
                Divider()
                RoundedButton("Checkout", theme: .black, style: .solid, action: {
                    showCheckout = true
                })
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
            }
            .background(Color.white)
            .sheet(isPresented: $showCheckout) {
                CheckoutScreen()
                    .environment(bagStore)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.hidden) 
            }
        }
    }

    // MARK: - Banner Card

    private var bannerCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Not in a Hurry?")
                .font(.system(size: 16, weight: .bold))
            Text("Select No Rush Shipping at checkout.")
                .font(.system(size: 16))

            HStack(spacing: 4) {
                ForEach(0..<3, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 1)
                        .fill(index == 2 ? Color.black : Color.gray.opacity(0.3))
                        .frame(width: 16, height: 3)
                }
            }
            .padding(.top, 4)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.lightGray96)
        .cornerRadius(12)
    }

    // MARK: - Promo Code

    private var promoCodeSection: some View {
        VStack(spacing: 0) {
            Divider()

            HStack {
                Text("Have a Promo Code?")
                    .font(.system(size: 16))
                Spacer()
                Image(systemName: "plus")
                    .font(.system(size: 16, weight: .medium))
            }
            .padding(.vertical, 16)

            Divider()
        }
    }

    // MARK: - Summary

    private var summarySection: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Subtotal")
                    .font(.system(size: 16))
                Spacer()
                Text(formattedSubtotal)
                    .font(.system(size: 16))
            }

            HStack {
                Text("Delivery")
                    .font(.system(size: 16))
                Spacer()
                Text("Standard - Free")
                    .font(.system(size: 16))
            }

            HStack {
                Text("Estimated Total")
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
                Text("\(formattedSubtotal) + Tax")
                    .font(.system(size: 16, weight: .semibold))
            }
        }
        .padding(.bottom, 24)
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
    BagScreen()
        .environment(BagStore())
        .environment(FavouriteStore())
        .environment(ProductsViewModel())
}
