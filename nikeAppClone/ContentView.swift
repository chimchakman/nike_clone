//
//  ContentView.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/22/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            TopBar()
            ContentGrid()
            BottomTab()
        }
    }
}

struct TopBar: View {
    var body: some View {
        HStack{
            Button(action: {}) {
                Image("vector")
            }.padding()
            Spacer()
            Spacer()
            Text("Socks")
            Spacer()
            Button(action: {}) {
                Image("setting")
            }.padding()
            Button(action: {}) {
                Image("magnifyingGlass")
            }.padding()
        }
    }
}

struct ContentGrid: View {
    let products: [Product] = [
        .init(name: "Nike Everyday Plus Cushioned", discription: "Training Crew Socks (3 Pairs)", colors: "10 Colours", price: "US$22", image: "image-1"),
        .init(name: "Nike Everyday Plus Cushioned", discription: "Training Crew Socks (6 Pairs)", colors: "7 Colours", price: "US$28", image: "image-2"),
        .init(name: "Nike Elite Crew", discription: "Basketball Socks", colors: "7 Colours", price: "US$16", image: "image-3"),
        .init(name: "Nike Everyday Plus Cushioned", discription: "Training Ankle Socks (6 Pairs)", colors: "5 Colours", price: "US$60", image: "image-4")
    ]
    var body: some View {
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
                
                Text(product.discription)
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

struct Product: Identifiable {
    let id: UUID = UUID()
    let name: String
    let discription: String
    let colors: String
    let price: String
    let image: String
}

#Preview {
    ContentView()
}
