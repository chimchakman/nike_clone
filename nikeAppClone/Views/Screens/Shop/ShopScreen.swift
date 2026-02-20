//
//  shopScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/27/26.
//

import SwiftUI

struct ShopScreen: View {
    @Environment(ProductsViewModel.self) var products: ProductsViewModel

    var body: some View {
        VStack(spacing: 0) {
            TopBar(title: "Socks", buttons: [.back, .settings, .search])
            ScrollView {
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: 6),
                        GridItem(.flexible(), spacing: 0)
                    ],
                    spacing: 18
                ) {
                    ForEach(products.getAll()) { product in
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

