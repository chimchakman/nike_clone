//
//  favouritesScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/27/26.
//

import SwiftUI

struct FavouritesScreen: View {
    @EnvironmentObject var favouriteStore: FavouriteStore
    private var likedProducts: [Product] {
            products.filter { favouriteStore.isFavourite($0.id) }
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
                        NavigationLink(value: product) {
                            ProductCard(product: product)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .navigationDestination(for: Product.self) { product in
            ProductDetailScreen(product: product)
        }
    }
}

#Preview {
    FavouritesScreen()
        .environmentObject(FavouriteStore())
}


