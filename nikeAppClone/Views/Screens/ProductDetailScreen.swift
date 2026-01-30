//
//  ProductDetailScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/28/26.
//

import SwiftUI

struct ProductDetailScreen: View {
    let product: Product
    let productDetail: ProductDetail
    init(product: Product) {
            guard let detail = productDetails.first(where: { $0.id == product.id }) else {
                fatalError("ProductDetail must exist for product id: \(product.id)")
            }
            self.product = product
            self.productDetail = detail
        }
    
    
    var body: some View {
        TopBar(title: productDetail.name, buttons: [.back, .search])
        ScrollView (.vertical, showsIndicators: false) {
            VStack {
                Image(productDetail.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack {
                        Image(productDetail.imageDetail1)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 160, height: 160)
                        Image(productDetail.imageDetail2)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 160, height: 160)
                        Image(productDetail.imageDetail3)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 160, height: 160)
                    }
                }
            }
            .frame(height: 629)
            
            VStack (alignment: .leading, spacing: 20) {
                Text(productDetail.category)
                    .font(.system(size: 16, weight: .regular, design: .default))
                
                Text(productDetail.name)
                    .font(.system(size: 28, weight: .medium, design: .default))
                
                Text(productDetail.price)
                    .font(.system(size: 16, weight: .medium, design: .default))
                
                Text(productDetail.longDescription)
                    .font(.system(size: 16, weight: .regular, design: .default))
                
                Text(productDetail.info)
                    .font(.system(size: 16, weight: .regular, design: .default))
                
                NavigationLink (value: productDetail) {
                    Text("View Product Details")
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .foregroundStyle(.gray)
                        .padding(.vertical, 20)
                }
                    Spacer()
            }
            .frame(maxWidth: 327, maxHeight: 516, alignment: .leading)
            .padding(.leading, 24)
            .padding(.top, 40)
            .navigationDestination(for: ProductDetail.self) { productDetail in
                ViewProductDetailScreen(productDetail: productDetail)
            }
            
            
            VStack (spacing: 20) {
                RoundedButton("Select Size", icon: .asset(name: "CaretDown"), borderColor: .gray.opacity(0.3), textColor: .black, action: {})
                    .frame(width: 327)
                RoundedButton("Add to Bag", fillColor: .black, borderColor: .clear, textColor: .white, action: {})
                    .frame(width: 327)
                RoundedButton("Favourite", icon: .asset(name: "HeartStraight"), borderColor: .gray.opacity(0.3), textColor: .black, action: {})
                    .frame(width: 327)
            }
            .frame(height: 267)
            .padding(.bottom, 30)
            
            VStack(alignment: .leading, spacing: 30) {

                        
                VStack(alignment: .leading, spacing: 10) {
                    Text("Get Your Gear Faster")
                        .font(.system(size: 18, weight: .semibold))

                    Text("Look for store pick up at checkout.")
                        .font(.system(size: 16))
                        .foregroundStyle(.black.opacity(0.65))

                    
                    HStack(spacing: 8) {
                        Capsule().frame(width: 16, height: 3).foregroundStyle(.black.opacity(0.18))
                        Capsule().frame(width: 16, height: 3).foregroundStyle(.black.opacity(0.18))
                        Capsule().frame(width: 16, height: 3).foregroundStyle(.black.opacity(0.18))
                        Capsule().frame(width: 16, height: 3).foregroundStyle(.black)
                    }
                    .padding(.top, 10)
                }
                .padding(18)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.black.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Delivery")
                        .font(.system(size: 20, weight: .semibold))

                    HStack(alignment: .firstTextBaseline, spacing: 10) {
                        Text(deliveryDateText)
                            .font(.system(size: 18))
                            .fixedSize(horizontal: false, vertical: true)

                        Button {
                            
                        } label: {
                            Text("Edit Location")
                                .font(.system(size: 18, weight: .semibold))
                                .underline()
                        }
                        .buttonStyle(.plain)
                    }
                }

                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Pick-Up")
                        .font(.system(size: 20, weight: .semibold))

                    Button {
                        
                    } label: {
                        Text("Find a Store")
                            .font(.system(size: 18, weight: .semibold))
                            .underline()
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ProductDetailScreen(product: products[3])
}
