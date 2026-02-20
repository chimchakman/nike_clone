//
//  Order.swift
//  nikeAppClone
//
//  Created by Claude on 2026-02-15.
//

import Foundation

enum OrderStatus: String, Codable {
    case pending
    case confirmed
    case shipped
    case delivered
    case cancelled
}

struct Order: Identifiable, Codable {
    let id: Int
    let userId: String
    let addressId: Int
    let paymentCardId: Int
    let totalAmount: Decimal
    let status: OrderStatus
    let createdAt: Date
    let updatedAt: Date
    let isDeleted: Bool

    var orderNumber: String {
        return "C" + String(format: "%011d", id)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case addressId = "address_id"
        case paymentCardId = "payment_card_id"
        case totalAmount = "total_amount"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isDeleted = "is_deleted"
    }
}

// For creating new orders (without database-generated fields)
struct OrderCreate: Codable {
    let userId: String
    let addressId: Int
    let paymentCardId: Int
    let totalAmount: Decimal
    let status: OrderStatus

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case addressId = "address_id"
        case paymentCardId = "payment_card_id"
        case totalAmount = "total_amount"
        case status
    }
}
