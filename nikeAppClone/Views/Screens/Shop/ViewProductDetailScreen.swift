//
//  ViewProductDetailScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/29/26.
//
import SwiftUI

struct ViewProductDetailScreen: View {
    var productDetail: ProductDetail
    var body: some View {
        TopBar(title: "View Product Details", buttons: [.back])
        ScrollView (.vertical, showsIndicators: false) {
            LazyVStack (spacing: 30) {
                VStack (alignment: .leading) {
                    Text(productDetail.copyTitle)
                        .font(.system(size: 23, weight: .medium))
                        .padding(.bottom, 10)
                    Text(productDetail.copyDescription)
                        .font(.system(size: 17, weight: .regular))
                        .lineSpacing(4)
                }
                VStack (alignment: .leading) {
                    Text("Benefits")
                        .font(.system(size: 23, weight: .medium))
                        .padding(.bottom, 10)
                    Text(productDetail.benefits)
                        .font(.system(size: 17, weight: .regular))
                        .lineSpacing(4)
                }
                VStack (alignment: .leading) {
                    Text("Product Details")
                        .font(.system(size: 23, weight: .medium))
                        .padding(.bottom, 10)
                    Text(productDetail.productDetails)
                        .font(.system(size: 17, weight: .regular))
                        .lineSpacing(4)
                }
                Spacer()
            }
        }
        .padding(.top, 30)
        .padding(.horizontal, 24)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ViewProductDetailScreen(productDetail: ProductDetails().getOne(id: "Nike03"))
}
