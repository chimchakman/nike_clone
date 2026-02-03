//
//  favouritesScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/27/26.
//

import SwiftUI

struct FavouritesScreen: View {
    @Environment(FavouriteStore.self) var favouriteStore: FavouriteStore
    @State private var selectedProduct: Product?
    @State private var sheetStep: SheetStep = .options
    @Binding var selectedTab: Tab
    private var likedProducts: [Product] {
            Products.getAll().filter { favouriteStore.isFavourite($0.id) }
        }
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button(action: { }) {
                    Text("Edit")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundStyle(.black)
                }
                .padding(.horizontal, 20)
            }
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            ScrollView {
                HStack {
                    Text("Favourite")
                        .font(.system(size: 36, weight: .medium))
                        .padding(.horizontal, 24)
                    Spacer()
                }
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: 6),
                        GridItem(.flexible(), spacing: 0)
                    ],
                    spacing: 18
                ) {
                    ForEach(likedProducts) { product in
                        Button {
                            selectedProduct = product
                            sheetStep = .options
                        } label: {
                            ProductCard(product: product, layOut: .favourite)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .sheet(item: $selectedProduct) { product in
            // 시트 콘텐츠
            ProductSheet(
                product: product,
                step: $sheetStep,
                onClose: { selectedTab = .bag }
            )
            .presentationDetents([.medium, .large])   // ✅ 반만 열리기(중간) + 필요시 확장(큰)
            .presentationDragIndicator(.visible)      // 위에 드래그 바 표시
            .presentationCornerRadius(16)
        }
    }
}



