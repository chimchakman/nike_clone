//
//  ProductService.swift
//  nikeAppClone
//
//  Created by Claude on 2/14/26.
//

import Foundation
import Supabase

enum ProductError: LocalizedError {
    case fetchFailed(String)
    case insertFailed(String)

    var errorDescription: String? {
        switch self {
        case .fetchFailed(let message):
            return "Failed to fetch products: \(message)"
        case .insertFailed(let message):
            return "Failed to insert product: \(message)"
        }
    }
}

final class ProductService {
    static let shared = ProductService()
    private let client = SupabaseManager.shared.client

    private init() {}

    /// Fetch all active products
    func fetchProducts() async throws -> [Product] {
        do {
            let products: [Product] = try await client
                .from("products")
                .select()
                .eq("is_deleted", value: false)
                .order("created_at", ascending: false)
                .execute()
                .value
            return products
        } catch {
            throw ProductError.fetchFailed(error.localizedDescription)
        }
    }

    /// Fetch product details by product ID
    func fetchProductDetails(productId: Int) async throws -> ProductDetail {
        do {
            let detail: ProductDetail = try await client
                .from("product_details")
                .select()
                .eq("product_id", value: productId)
                .eq("is_deleted", value: false)
                .single()
                .execute()
                .value

            return detail
        } catch {
            throw ProductError.fetchFailed(error.localizedDescription)
        }
    }

    /// Insert product (for initial data seeding)
    func insertProduct(_ product: Product) async throws {
        do {
            try await client
                .from("products")
                .insert(product)
                .execute()
        } catch {
            throw ProductError.insertFailed(error.localizedDescription)
        }
    }

    /// Insert product detail (for initial data seeding)
    func insertProductDetail(_ detail: ProductDetail) async throws {
        do {
            try await client
                .from("product_details")
                .insert(detail)
                .execute()
        } catch {
            throw ProductError.insertFailed(error.localizedDescription)
        }
    }
}
