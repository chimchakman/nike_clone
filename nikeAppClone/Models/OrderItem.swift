//
//  OrderItem.swift
//  nikeAppClone
//
//  Created by Claude on 2026-02-15.
//

import Foundation

struct OrderItem: Identifiable, Codable {
    let id: Int
    let orderId: Int
    let productId: Int
    let size: String?
    let quantity: Int
    let priceAtPurchase: Decimal
    let createdAt: Date
    let isDeleted: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case orderId = "order_id"
        case productId = "product_id"
        case size
        case quantity
        case priceAtPurchase = "price_at_purchase"
        case createdAt = "created_at"
        case isDeleted = "is_deleted"
    }
}

// For creating new order items (without database-generated fields)
struct OrderItemCreate: Codable {
    let productId: Int
    let size: String?
    let quantity: Int
    let priceAtPurchase: Decimal

    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case size
        case quantity
        case priceAtPurchase = "price_at_purchase"
    }
}

// For inserting order items with order_id (used internally by OrderService)
struct OrderItemInsert: Codable {
    let orderId: Int
    let productId: Int
    let size: String?
    let quantity: Int
    let priceAtPurchase: Decimal

    enum CodingKeys: String, CodingKey {
        case orderId = "order_id"
        case productId = "product_id"
        case size
        case quantity
        case priceAtPurchase = "price_at_purchase"
    }
}
