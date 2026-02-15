//
//  FavouriteStore.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/30/26.
//

import SwiftUI
import Foundation
import Combine

@Observable
final class FavouriteStore {
    private(set) var favouriteIDs: Set<Int> = []
    private let defaults: UserDefaults
    private let storageKey = "favourite_product_ids"
    private let migrationKey = "favourites_migrated_to_supabase"
    private var syncTask: Task<Void, Never>?

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        load()
    }

    func isFavourite(_ productID: Int) -> Bool {
        favouriteIDs.contains(productID)
    }

    func toggle(_ productID: Int) {
        let isFavourite: Bool
        if favouriteIDs.contains(productID) {
            favouriteIDs.remove(productID)
            isFavourite = false
        } else {
            favouriteIDs.insert(productID)
            isFavourite = true
        }
        save()
        queueSync(productId: productID, isFavourite: isFavourite)
    }

    // MARK: - Persistence (UserDefaults)

    private func load() {
        let array = defaults.array(forKey: storageKey) as? [Int] ?? []
        favouriteIDs = Set(array)
    }

    private func save() {
        defaults.set(Array(favouriteIDs), forKey: storageKey)
    }

    func removeAll() {
        favouriteIDs.removeAll()
        save()
    }

    // MARK: - Supabase Sync

    func migrateToSupabase(userId: UUID) async {
        guard !defaults.bool(forKey: migrationKey) else { return }

        // Fetch existing server data
        let serverIds = try? await FavouriteService.shared.fetchFavourites(userId: userId)

        // Merge local with server
        for localId in favouriteIDs {
            let existsOnServer = serverIds?.contains(localId) ?? false
            if !existsOnServer {
                try? await FavouriteService.shared.addFavourite(userId: userId, productId: localId)
            }
        }

        // Mark migration complete
        defaults.set(true, forKey: migrationKey)

        // Refresh from server
        await refreshFromServer(userId: userId)
    }

    func refreshFromServer(userId: UUID) async {
        guard let serverIds = try? await FavouriteService.shared.fetchFavourites(userId: userId) else {
            return
        }
        favouriteIDs = serverIds
        save() // Keep local cache in sync
    }

    private func queueSync(productId: Int, isFavourite: Bool) {
        guard let userId = AuthService.shared.currentUserId else { return }

        syncTask?.cancel()
        syncTask = Task {
            try? await Task.sleep(for: .seconds(1))
            if isFavourite {
                try? await FavouriteService.shared.addFavourite(userId: userId, productId: productId)
            } else {
                try? await FavouriteService.shared.removeFavourite(userId: userId, productId: productId)
            }
        }
    }
}
