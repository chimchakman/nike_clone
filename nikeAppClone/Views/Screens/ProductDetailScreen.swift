//
//  ProductDetailScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/28/26.
//

import SwiftUI

struct ProductDetailScreen: View {
    var product: Product = Product(
        name: "Nike Everyday Plus Cushioned",
        description: "The Nike Everyday Plus Cushioned Socks bring comfort to your workout with extra cushioning under the heel and forefoot and a snug, supportive arch band. Sweat-wicking power and breathability up top help keep your feet dry and cool to help push you through that extra set.",
        colors: "black",
        price: "US$10",
        image: "productDetail1"
    )
    private var deliveryDateText: String {
        let calendar = Calendar.current
        let today = Date()

        let startDate = calendar.date(byAdding: .day, value: 3, to: today)!
        let endDate = calendar.date(byAdding: .day, value: 5, to: today)!

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "EEE, d MMM"

        return "Arrives \(formatter.string(from: startDate))\nto \(formatter.string(from: endDate))"
    }
    
    var body: some View {
        TopBar(title: product.name, buttons: [.back, .search])
        ScrollView (.vertical, showsIndicators: false) {
            VStack {
                Image("productDetail1")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack {
                        Image("productDetail2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 160, height: 160)
                        Image("productDetail3")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 160, height: 160)
                        Image("productDetail4")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 160, height: 160)
                    }
                }
            }
            .frame(height: 629)
            
            VStack (alignment: .leading, spacing: 20) {
                Text("Training Crew Socks")
                    .font(.system(size: 16, weight: .regular, design: .default))
                    
                Text(product.name)
                    .font(.system(size: 28, weight: .medium, design: .default))
                    
                Text(product.price)
                    .font(.system(size: 16, weight: .medium, design: .default))
                    
                Text(product.description)
                    .font(.system(size: 16, weight: .regular, design: .default))
                
                Text("• Shown: Multi-Color\n• Style: SX6897-965")
                    .font(.system(size: 16, weight: .regular, design: .default))
                    
                Text("View Product Details")
                    .font(.system(size: 16, weight: .regular, design: .default))
                    .foregroundStyle(.gray)
                    .padding(.vertical, 20)
                
                Spacer()
            }
            .frame(maxWidth: 327, maxHeight: 516, alignment: .leading)
            .padding(.leading, 24)
            .padding(.top, 40)
            
            VStack (spacing: 20) {
                Button {} label: {
                    Image("CTA")
                }
                Button {} label: {
                    Image("CTA-4")
                }
                Button {} label: {
                    Image("CTA-7")
                }
            }
            .frame(height: 267)
            
            VStack(alignment: .leading, spacing: 24) {

                        
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
    }
}

#Preview {
    ProductDetailScreen()
}
