//
//  ProductData.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/29/26.
//

import SwiftUI

@Observable
final class Products {
    private let productList: [Product] = [
        .init(id: "Nike01", name: "Nike Everyday Plus Cushioned", description: "Training Crew Socks (3 Pairs)", colors: "10 Colours", price: "US$22", image: "image-1"),
        .init(id: "Nike02", name: "Nike Everyday Plus Cushioned", description: "Training Crew Socks (6 Pairs)", colors: "7 Colours", price: "US$28", image: "image-2"),
        .init(id: "Nike03", name: "Nike Elite Crew", description: "Basketball Socks", colors: "7 Colours", price: "US$16", image: "image-3"),
        .init(id: "Nike04", name: "Nike Everyday Plus Cushioned", description: "Training Ankle Socks (6 Pairs)", colors: "5 Colours", price: "US$60", image: "image-4")
    ]

    func getAll() -> [Product] {
        return productList
    }

    func getOne(id: String) -> Product {
        return productList.first(where: { $0.id == id })!
    }
}

@Observable
final class HomeProducts {
    private let homeProductList: [Product] = [
        .init(id: "Nike05", name: "Air Jordan XXXVI", description: "N/A", colors: "N/A", price: "US$185", image: "homeImage2"),
        .init(id: "Nike06", name: "Air Jordan XXXVI", description: "N/A", colors: "N/A", price: "US$185", image: "homeImage2")
    ]

    func getAll() -> [Product] {
        return homeProductList
    }

    func getOne(id: String) -> Product {
        return homeProductList.first(where: { $0.id == id })!
    }
}
