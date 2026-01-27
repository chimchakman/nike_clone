//
//  shopScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/27/26.
//

import SwiftUI

struct ShopScreen: View {
    let products: [Product] = [
        .init(name: "Nike Everyday Plus Cushioned", description: "Training Crew Socks (3 Pairs)", colors: "10 Colours", price: "US$22", image: "image-1"),
        .init(name: "Nike Everyday Plus Cushioned", description: "Training Crew Socks (6 Pairs)", colors: "7 Colours", price: "US$28", image: "image-2"),
        .init(name: "Nike Elite Crew", description: "Basketball Socks", colors: "7 Colours", price: "US$16", image: "image-3"),
        .init(name: "Nike Everyday Plus Cushioned", description: "Training Ankle Socks (6 Pairs)", colors: "5 Colours", price: "US$60", image: "image-4")
    ]
    var body: some View {
        TopBar(title: "Socks", buttons: [.back, .settings, .search])
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 6),
                GridItem(.flexible(), spacing: 0)
            ], spacing: 18) {
                ForEach(products) {
                    ProductCard(product: $0)
                }
            }
        }
    }
}
