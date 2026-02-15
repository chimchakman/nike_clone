//
//  ProductDetail.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/28/26.
//

import SwiftUI

struct ProductDetail: Identifiable, Hashable, Codable {
    let productId: Int
    let name: String
    let category: String
    let longDescription: String
    let info: String
    let price: Decimal
    let imageUrl: String
    let imageDetail1: String
    let imageDetail2: String
    let imageDetail3: String
    let copyTitle: String
    let copyDescription: String
    let benefits: String
    let productDetails: String
    let createdAt: Date
    let isDeleted: Bool

    // Computed property for Identifiable conformance
    var id: Int { productId }

    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case name
        case category
        case longDescription = "long_description"
        case info
        case price
        case imageUrl = "image_url"
        case imageDetail1 = "image_detail_1"
        case imageDetail2 = "image_detail_2"
        case imageDetail3 = "image_detail_3"
        case copyTitle = "copy_title"
        case copyDescription = "copy_description"
        case benefits
        case productDetails = "product_details"
        case createdAt = "created_at"
        case isDeleted = "is_deleted"
    }
}

// MARK: - Preview Helper
extension ProductDetail {
    static let preview = ProductDetail(
        productId: 1,
        name: "Nike Everyday Plus Cushioned",
        category: "Training Crew Socks",
        longDescription: "The Nike Everyday Plus Cushioned Socks bring comfort to your workout with extra cushioning under the heel and forefoot and a snug, supportive arch band. Sweat-wicking power and breathability up top help keep your feet dry and cool to help push you through that extra set.",
        info: "Shown: White/Black\nStyle: DX9632-100",
        price: Decimal(string: "18.97")!,
        imageUrl: "image-1",
        imageDetail1: "image-1",
        imageDetail2: "image-2",
        imageDetail3: "image-3",
        copyTitle: "Maximum Comfort",
        copyDescription: "Extra cushioning under the heel and forefoot provides maximum comfort during your training.",
        benefits: "• Dri-FIT technology helps keep your feet dry and comfortable\n• Cushioned sole provides comfort with every step\n• Arch band provides a supportive fit",
        productDetails: "• 58% cotton/39% polyester/2% spandex/1% nylon\n• Machine wash\n• Imported",
        createdAt: Date(),
        isDeleted: false
    )
}
