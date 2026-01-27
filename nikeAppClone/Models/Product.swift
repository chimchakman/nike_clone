//
//  Product.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/27/26.
//

import SwiftUI

struct Product: Identifiable {
    let id: UUID = UUID()
    let name: String
    let description: String
    let colors: String
    let price: String
    let image: String
}
