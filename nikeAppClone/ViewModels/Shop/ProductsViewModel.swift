//
//  ProductsViewModel.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/29/26.
//

import Foundation

@Observable
final class ProductsViewModel {
    private(set) var products: [Product] = []
    private(set) var homeProducts: [Product] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    func loadProducts() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let allProducts = try await ProductService.shared.fetchProducts()

            // Filter by category
            products = allProducts.filter { $0.category == "Socks" }
            homeProducts = Array(allProducts.filter { $0.category == "Shoes" }.prefix(2))

        } catch {
            errorMessage = error.localizedDescription
        }
    }

    /// Load a single product by ID and cache it
    func loadProduct(id: Int) async {
        // Check if already loaded
        if getProduct(id: id) != nil {
            return
        }

        do {
            let product = try await ProductService.shared.fetchProduct(id: id)

            // Add to appropriate array based on category
            if product.category == "Socks" {
                products.append(product)
            } else if product.category == "Shoes" {
                homeProducts.append(product)
            } else {
                // Add to products array as default
                products.append(product)
            }
        } catch {
            print("Failed to load product \(id): \(error.localizedDescription)")
        }
    }

    func getProduct(id: Int) -> Product? {
        products.first(where: { $0.id == id }) ?? homeProducts.first(where: { $0.id == id })
    }

    func getAll() -> [Product] {
        return products
    }

    func getOne(id: Int) -> Product {
        return getProduct(id: id) ?? Product(
            id: id,
            name: "Unknown Product",
            description: "",
            colors: "",
            price: 0,
            imageUrl: "",
            category: "",
            createdAt: Date(),
            isDeleted: false
        )
    }
}
