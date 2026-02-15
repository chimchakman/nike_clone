//
//  BagItemRow.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/3/26.
//

import SwiftUI

struct BagItemRow: View {
    let bagItem: BagItem
    let product: Product
    let onQuantityChange: (Int) -> Void

    @State private var showQuantityPicker = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Product image + info
            HStack(alignment: .top, spacing: 12) {
                VStack(spacing: 6) {
                    Image(product.imageUrl)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .background(Color.lightGray96)

                    // Image page dots
                    HStack(spacing: 4) {
                        ForEach(0..<5, id: \.self) { i in
                            Circle()
                                .fill(i == 0 ? Color.black : Color.gray.opacity(0.3))
                                .frame(width: 5, height: 5)
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(product.name)
                        .font(.system(size: 15, weight: .medium))
                    Text(product.description)
                        .font(.system(size: 14))
                        .foregroundStyle(.secondary)
                    Text("Size \(bagItem.size)")
                        .font(.system(size: 14))
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.top, 16)

            // Qty + Price
            HStack {
                Button {
                    showQuantityPicker = true
                } label: {
                    HStack(spacing: 6) {
                        Text("Qty \(bagItem.quantity)")
                            .font(.system(size: 16))
                        Image(systemName: "chevron.down")
                            .font(.system(size: 12))
                    }
                    .foregroundStyle(.black)
                }

                Spacer()

                Text(formattedItemPrice)
                    .font(.system(size: 16))
            }
            .padding(.top, 16)

            // Delivery
            VStack(alignment: .leading, spacing: 4) {
                Text("Delivery")
                    .font(.system(size: 16, weight: .medium))
                    .padding(.top, 20)

                Text("Arrives Wed, 11 May")
                    .font(.system(size: 14))
                HStack(spacing: 0) {
                    Text("to Fri, 13 May  ")
                        .font(.system(size: 14))
                    Text("Edit Location")
                        .font(.system(size: 14))
                        .underline()
                }
            }

            // Pick-Up
            VStack(alignment: .leading, spacing: 4) {
                Text("Pick-Up")
                    .font(.system(size: 16, weight: .medium))
                    .padding(.top, 16)

                Text("Find a Store")
                    .font(.system(size: 14))
                    .underline()
            }
            .padding(.bottom, 16)
        }
        .sheet(isPresented: $showQuantityPicker) {
            QuantityPickerSheet(
                currentQuantity: bagItem.quantity,
                onDone: { newQty in
                    onQuantityChange(newQty)
                    showQuantityPicker = false
                }
            )
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
    }

    private var formattedItemPrice: String {
        let unitPrice = NSDecimalNumber(decimal: product.price).doubleValue
        let totalPrice = unitPrice * Double(bagItem.quantity)
        return String(format: "US$%.2f", totalPrice)
    }
}
