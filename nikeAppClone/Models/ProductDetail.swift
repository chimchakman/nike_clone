//
//  ProductDetail.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/28/26.
//

import SwiftUI

struct ProductDetail: Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String
    let longDescription: String
    let colors: String
    let price: String
    let image: String
}
