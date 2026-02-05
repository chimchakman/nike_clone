//
//  QuantityPickerSheet.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/4/26.
//

import SwiftUI

struct QuantityPickerSheet: View {
    let currentQuantity: Int
    let onDone: (Int) -> Void

    @State private var selectedQuantity: Int
    @Environment(\.dismiss) private var dismiss

    init(currentQuantity: Int, onDone: @escaping (Int) -> Void) {
        self.currentQuantity = currentQuantity
        self.onDone = onDone
        self._selectedQuantity = State(initialValue: currentQuantity)
    }

    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 24)

            // Remove
            Button {
                onDone(0)
            } label: {
                Text("Remove")
                    .font(.system(size: 18))
                    .foregroundStyle(.gray)
            }

            Spacer().frame(height: 16)

            // Quantity list
            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(1...10, id: \.self) { qty in
                            quantityRow(qty)
                                .id(qty)
                        }
                    }
                }
                .onAppear {
                    proxy.scrollTo(selectedQuantity, anchor: .center)
                }
            }

            // Done button
            RoundedButton("Done", theme: .black, style: .solid) {
                onDone(selectedQuantity)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
    }

    @ViewBuilder
    private func quantityRow(_ qty: Int) -> some View {
        let isSelected = qty == selectedQuantity

        Button {
            selectedQuantity = qty
        } label: {
            VStack(spacing: 0) {
                if isSelected {
                    Divider()
                }

                Text("\(qty)")
                    .font(.system(size: 20, weight: isSelected ? .semibold : .regular))
                    .foregroundStyle(isSelected ? .black : .gray)
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)

                if isSelected {
                    Divider()
                }
            }
        }
    }
}

#Preview {
    QuantityPickerSheet(currentQuantity: 1, onDone: { _ in })
}
