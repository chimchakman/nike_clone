//
//  FavouriteService.swift
//  nikeAppClone
//
//  Created by Claude on 2/14/26.
//

import Foundation
import Supabase

enum FavouriteError: LocalizedError {
    case fetchFailed(String)
    case syncFailed(String)

    var errorDescription: String? {
        switch self {
        case .fetchFailed(let message):
            return "Failed to fetch favourites: \(message)"
        case .syncFailed(let message):
            return "Failed to sync favourite: \(message)"
        }
    }
}

struct FavouriteItem: Codable {
    let id: Int?
    let userId: UUID
    let productId: Int
    let createdAt: Date
    let isDeleted: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case productId = "product_id"
        case createdAt = "created_at"
        case isDeleted = "is_deleted"
    }
}

final class FavouriteService {
    static let shared = FavouriteService()
    private let client = SupabaseManager.shared.client

    private init() {}

    /// Fetch favourites from server
    func fetchFavourites(userId: UUID) async throws -> Set<Int> {
        do {
            let items: [FavouriteItem] = try await client
                .from("favourites")
                .select()
                .eq("user_id", value: userId.uuidString)
                .eq("is_deleted", value: false)
                .execute()
                .value

            return Set(items.map { $0.productId })
        } catch {
            throw FavouriteError.fetchFailed(error.localizedDescription)
        }
    }

    /// Add favourite to server
    func addFavourite(userId: UUID, productId: Int) async throws {
        do {
            let item = FavouriteItem(
                id: nil,
                userId: userId,
                productId: productId,
                createdAt: Date(),
                isDeleted: false
            )

            try await client
                .from("favourites")
                .insert(item)
                .execute()
        } catch {
            // Ignore duplicate key errors (already exists)
            if !error.localizedDescription.contains("duplicate") {
                throw FavouriteError.syncFailed(error.localizedDescription)
            }
        }
    }

    /// Remove favourite from server
    func removeFavourite(userId: UUID, productId: Int) async throws {
        do {
            try await client
                .from("favourites")
                .update(["is_deleted": true])
                .eq("user_id", value: userId.uuidString)
                .eq("product_id", value: productId)
                .execute()
        } catch {
            throw FavouriteError.syncFailed(error.localizedDescription)
        }
    }
}
