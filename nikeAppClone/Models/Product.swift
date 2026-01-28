//
//  Product.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/27/26.
//

import SwiftUI

struct Product: Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String
    let description: String
    let colors: String
    let price: String
    let image: String
}

let products: [Product] = [
    .init(name: "Nike Everyday Plus Cushioned", description: "Training Crew Socks (3 Pairs)", colors: "10 Colours", price: "US$22", image: "image-1"),
    .init(name: "Nike Everyday Plus Cushioned", description: "Training Crew Socks (6 Pairs)", colors: "7 Colours", price: "US$28", image: "image-2"),
    .init(name: "Nike Elite Crew", description: "Basketball Socks", colors: "7 Colours", price: "US$16", image: "image-3"),
    .init(name: "Nike Everyday Plus Cushioned", description: "Training Ankle Socks (6 Pairs)", colors: "5 Colours", price: "US$60", image: "image-4")
]

let homeProducts: [Product] = [
    .init(name: "Air Jordan XXXVI", description: "N/A", colors: "N/A", price: "US$185", image: "homeImage2"),
    .init(name: "Air Jordan XXXVI", description: "N/A", colors: "N/A", price: "US$185", image: "homeImage2")
]
