//
//  homeScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/27/26.
//

import SwiftUI

struct HomeScreen: View {
    @Environment(HomeProducts.self) var homeProducts: HomeProducts

    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            VStack (alignment: .leading) {
                Text("Discover")
                    .font(.system(size: 28, weight: .bold, design: .default))
                    .padding(.leading, 24)
                Text(
                    Date(),
                    format: .dateTime
                        .weekday(.abbreviated)
                        .day()
                        .month(.abbreviated)
                )
                .font(.system(size: 16, weight: .regular, design: .default))
                .foregroundStyle(.gray)
                .padding(.leading, 24)
            }
            .frame(maxWidth: .infinity, maxHeight: 160, alignment: .leading)
            .frame(height: 160)
            
            Image("homeImage1")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
            
            VStack (alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("what's new")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                    Text("The latest arrivals from Nike")
                        .font(.system(size: 28, weight: .semibold, design: .default))
                        .foregroundStyle(.gray)
                }
                .padding(.top, 40)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 6) {
                        ForEach(homeProducts.getAll()) { product in
                            ProductCardHoriontal(product: product)
                                .frame(width: 314)
                        }
                    }
                    .padding(.horizontal, 10)
                }
            }
            .padding(.leading, 24)
            .frame(maxWidth: .infinity, minHeight: 562, maxHeight: 562)
            
            Image("homeImage3")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    HomeScreen()
}
