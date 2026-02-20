//
//  Product.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/27/26.
//

import Foundation

struct Product: Identifiable, Hashable, Codable {
    let id: Int
    let name: String
    let description: String
    let colors: String
    let price: Decimal
    let imageUrl: String
    let category: String
    let createdAt: Date
    let isDeleted: Bool

    // Computed property for backward compatibility
    var priceString: String {
        "\(price)"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case colors
        case price
        case imageUrl = "image_url"
        case category
        case createdAt = "created_at"
        case isDeleted = "is_deleted"
    }
}

// MARK: - Preview Helper
extension Product {
    static let preview = Product(
        id: 1,
        name: "Nike Everyday Plus Cushioned",
        description: "Training Crew Socks (3 Pairs)",
        colors: "1 Color",
        price: Decimal(string: "18.97")!,
        imageUrl: "https://via.placeholder.com/400x400.png?text=Preview",
        category: "Socks",
        createdAt: Date(),
        isDeleted: false
    )
}


