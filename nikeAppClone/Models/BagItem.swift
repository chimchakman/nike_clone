//
//  BagItem.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/3/26.
//

import Foundation

struct BagItem: Identifiable, Hashable, Codable {
    let id: String
    let productId: String
    let size: String
    var quantity: Int

    init(productId: String, size: String, quantity: Int = 1) {
        self.id = UUID().uuidString
        self.productId = productId
        self.size = size
        self.quantity = quantity
    }
}
