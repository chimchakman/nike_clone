//
//  BagItem.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/3/26.
//

import Foundation

struct BagItem: Identifiable, Hashable, Codable {
    let id: Int?
    var userId: UUID?
    let productId: Int
    let size: String
    var quantity: Int
    let createdAt: Date
    var updatedAt: Date
    var isDeleted: Bool

    init(productId: Int, size: String, quantity: Int = 1) {
        self.id = nil
        self.userId = nil
        self.productId = productId
        self.size = size
        self.quantity = quantity
        self.createdAt = Date()
        self.updatedAt = Date()
        self.isDeleted = false
    }
}
