//
//  ProductCard.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/27/26.
//
import SwiftUI

struct ProductCard: View {
    var product: Product
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                Button(action: {}) {
                    Image("Icon")
                        .padding(10)
                }
            }
            .frame(height: 200)
            VStack(alignment: .leading, spacing: 5) {
                Text(product.name)
                    .font(.system(size: 12, weight: .medium))
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(product.description)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(.black.opacity(0.55))
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(product.colors)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(.black.opacity(0.55))
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(product.price)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.black)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 15)
            .padding(.top, 8)
            .frame(height: 120, alignment: .top)
        }
    }
}
