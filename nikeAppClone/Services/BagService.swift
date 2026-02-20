//
//  BagService.swift
//  nikeAppClone
//
//  Created by Claude on 2/14/26.
//

import Foundation
import Supabase

enum BagError: LocalizedError {
    case fetchFailed(String)
    case syncFailed(String)

    var errorDescription: String? {
        switch self {
        case .fetchFailed(let message):
            return "Failed to fetch bag items: \(message)"
        case .syncFailed(let message):
            return "Failed to sync bag item: \(message)"
        }
    }
}

final class BagService {
    static let shared = BagService()
    private let client = SupabaseManager.shared.client

    private init() {}

    /// Fetch bag items from server
    func fetchBagItems(userId: UUID) async throws -> [BagItem] {
        do {
            let items: [BagItem] = try await client
                .from("bag_items")
                .select()
                .eq("user_id", value: userId.uuidString)
                .eq("is_deleted", value: false)
                .execute()
                .value
            return items
        } catch {
            throw BagError.fetchFailed(error.localizedDescription)
        }
    }

    /// Sync local bag item to server
    func syncBagItem(userId: UUID, item: BagItem) async throws {
        do {
            var mutableItem = item
            mutableItem.userId = userId
            mutableItem.updatedAt = Date()

            if let itemId = item.id {
                // Update existing
                try await client
                    .from("bag_items")
                    .update(mutableItem)
                    .eq("id", value: itemId)
                    .execute()
            } else {
                // Insert new
                try await client
                    .from("bag_items")
                    .insert(mutableItem)
                    .execute()
            }
        } catch {
            throw BagError.syncFailed(error.localizedDescription)
        }
    }

    /// Delete bag item from server
    func deleteBagItem(itemId: Int) async throws {
        do {
            struct UpdatePayload: Encodable {
                let is_deleted: Bool
                let updated_at: Date
            }

            let payload = UpdatePayload(is_deleted: true, updated_at: Date())
            try await client
                .from("bag_items")
                .update(payload)
                .eq("id", value: itemId)
                .execute()
        } catch {
            throw BagError.syncFailed(error.localizedDescription)
        }
    }
}
