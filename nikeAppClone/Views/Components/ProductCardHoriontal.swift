//
//  ProductCardHoriontal.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/28/26.
//

import SwiftUI

struct ProductCardHoriontal: View {
    var product: Product
    var body: some View {
        VStack(alignment: .leading) {
            Image(product.image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(product.name)
                    .font(.system(size: 14, weight: .medium))
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(product.price)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.gray)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .frame(height: 384, alignment: .top)
    }
}
