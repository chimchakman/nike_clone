//
//  ProductDetailsViewModel.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/29/26.
//

import Foundation

@Observable
final class ProductDetailsViewModel {
    private(set) var productDetails: [Int: ProductDetail] = [:]
    private(set) var isLoading: Set<Int> = []
    private(set) var errorMessages: [Int: String] = [:]

    func loadProductDetail(productId: Int) async {
        guard productDetails[productId] == nil else { return }

        isLoading.insert(productId)
        defer { isLoading.remove(productId) }

        do {
            let detail = try await ProductService.shared.fetchProductDetails(productId: productId)
            productDetails[productId] = detail
            errorMessages.removeValue(forKey: productId)
        } catch {
            errorMessages[productId] = error.localizedDescription
        }
    }

    func getProductDetail(id: Int) -> ProductDetail? {
        productDetails[id]
    }
}
