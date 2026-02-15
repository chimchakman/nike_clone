//
//  ProductDetailScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/28/26.
//

import SwiftUI

struct ProductDetailScreen: View {
    @Environment(FavouriteStore.self) var favouriteStore: FavouriteStore
    @Environment(BagStore.self) var bagStore: BagStore
    @Environment(ProductDetailsViewModel.self) var productDetails: ProductDetailsViewModel
    let product: Product
    var productDetail: ProductDetail? {
        productDetails.getProductDetail(id: product.id)
    }
    @State private var selectedSize: String = "M"
    init(product: Product) {
        self.product = product
    }
    
    
    var body: some View {
        TopBar(title: productDetail?.name ?? product.name, buttons: [.back, .search])
        ScrollView (.vertical, showsIndicators: false) {
            if let productDetail = productDetail {
                VStack {
                    Image(productDetail.imageUrl)
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

                Text("US$\(NSDecimalNumber(decimal: productDetail.price).doubleValue, specifier: "%.2f")")
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
                RoundedButton("Select Size", icon: .right(name: "CaretDown"), theme: .black, style: .outline, action: {})
                    .frame(width: 327)
                RoundedButton("Add to Bag", theme: .black, style: .solid, action: {
                    bagStore.add(productId: product.id, size: selectedSize)
                })
                    .frame(width: 327)
                RoundedButton("Favourite", icon: .right(name: favouriteStore.isFavourite(product.id) ? "likeFilled" : "like"), theme: .black, style: .outline, action: {favouriteStore.toggle(product.id)})
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
            } else {
                ProgressView()
                    .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .task {
            await productDetails.loadProductDetail(productId: product.id)
        }
    }
}

#Preview {
    ProductDetailScreen(product: .preview)
        .environment(FavouriteStore())
        .environment(BagStore())
        .environment(ProductDetailsViewModel())
}
