//
//  FavouritesDetailScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/3/26.
//

import SwiftUI

enum SheetStep {
    case options
    case added
}

struct ProductSheet: View {
    let product: Product
    @Binding var step: SheetStep
    let onClose: () -> Void

    @State private var selectedSize: String = "L"
    @Environment(\.dismiss) private var dismiss
    @Environment(BagStore.self) var bagStore: BagStore

    var body: some View {
        switch step {
        case .options:
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12) {
                    Image(product.image)
                        .frame(height: 202)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(product.name).font(.headline)
                        Text("Shoes").foregroundStyle(.secondary)
                        Spacer()
                        Text(product.price).font(.headline)
                    }
                    .frame(maxHeight: 202)
                }

                Text("Size").font(.title3.bold())

                // 간단한 사이즈 선택 UI
                HStack {
                    ForEach(["S","M","L","XL"], id: \.self) { size in
                        Button {
                            selectedSize = size
                        } label: {
                            Text(size)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(.clear)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedSize == size ? Color.black : Color.gray.opacity(0.4), lineWidth: selectedSize == size ? 4 : 2)
                                )
                                .cornerRadius(10)
                        }
                        .foregroundStyle(.primary)
                    }
                }

                Spacer()
                RoundedButton("Add to Bag", theme: .black, style: .solid, action: {
                    bagStore.add(productId: product.id, size: selectedSize)
                    withAnimation {
                        step = .added
                    }
                })
            }
            .padding()

        case .added:
            VStack(spacing: 18) {
                Spacer()
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 54, weight: .regular))
                Text("Added to Bag")
                    .font(.title2.bold())
                Spacer()

                RoundedButton("View Bag", theme: .black, style: .solid, action: {
                    dismiss()
                    onClose()
                })
            }
            .padding()
        }
    }
}

#Preview {
    ProductSheet(product: Products().getOne(id: "Nike01"), step: .constant(.options), onClose: {})
        .environment(BagStore())
}
