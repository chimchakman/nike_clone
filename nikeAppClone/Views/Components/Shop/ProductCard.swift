//
//  ProductCard.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/27/26.
//
import SwiftUI

struct ProductCard: View {
    @Environment(FavouriteStore.self) var favouriteStore: FavouriteStore
    
    enum Layout {
        case shop
        case favourite
    }
    var product: Product
    var layOut: Layout
    private var textHeight: CGFloat
    
    init(product: Product, layOut: Layout = .shop) {
        self.product = product
        self.layOut = layOut
        self.textHeight = layOut == .shop ? 120 : 80
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                if layOut == .shop {
                    Button(action: {favouriteStore.toggle(product.id)}) {
                        Image(favouriteStore.isFavourite(product.id)
                              ? "likeFilled"
                              : "like")
                        .padding(10)
                    }
                }
            }
            .frame(height: 200)
            VStack(alignment: .leading, spacing: 5) {
                Text(product.name)
                    .font(.system(size: 15, weight: .medium))
                    .fixedSize(horizontal: false, vertical: true)
                
                if layOut == .shop {
                    Text(product.description)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundStyle(.black.opacity(0.55))
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text(product.colors)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundStyle(.black.opacity(0.55))
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Text(product.price)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.black)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 15)
            .padding(.top, 8)
            .frame(height: textHeight, alignment: .top)
        }
    }
}
