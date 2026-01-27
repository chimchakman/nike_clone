//
//  shopScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/27/26.
//

import SwiftUI

struct ShopScreen: View {
    
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

