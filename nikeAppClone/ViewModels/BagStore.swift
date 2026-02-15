//
//  BagStore.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/3/26.
//

import Foundation

@Observable
final class BagStore {
    private(set) var items: [BagItem] = []
    private let defaults: UserDefaults
    private let storageKey = "bag_items"
    private let migrationKey = "bag_migrated_to_supabase"
    private var syncTask: Task<Void, Never>?

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        load()
    }

    // MARK: - Public API

    func add(productId: Int, size: String, quantity: Int = 1) {
        if let index = items.firstIndex(where: {
            $0.productId == productId && $0.size == size
        }) {
            items[index].quantity += quantity
        } else {
            items.append(BagItem(productId: productId, size: size, quantity: quantity))
        }
        save()
        queueSync()
    }

    func remove(itemId: Int?) {
        items.removeAll { $0.id == itemId }
        save()
        queueSync()
    }

    func updateQuantity(itemId: Int?, quantity: Int) {
        guard let index = items.firstIndex(where: { $0.id == itemId }) else { return }
        if quantity <= 0 {
            items.remove(at: index)
        } else {
            items[index].quantity = quantity
        }
        save()
        queueSync()
    }

    func clear() {
        items.removeAll()
        save()
        queueSync()
    }

    var totalItemCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }

    var isEmpty: Bool {
        items.isEmpty
    }

    // MARK: - Supabase Sync

    func migrateToSupabase(userId: UUID) async {
        guard !defaults.bool(forKey: migrationKey) else { return }

        // Fetch existing server data
        let serverItems = try? await BagService.shared.fetchBagItems(userId: userId)

        // Merge local items with server
        for localItem in items {
            let existsOnServer = serverItems?.contains(where: {
                $0.productId == localItem.productId && $0.size == localItem.size
            }) ?? false

            if !existsOnServer {
                try? await BagService.shared.syncBagItem(userId: userId, item: localItem)
            }
        }

        // Mark migration complete
        defaults.set(true, forKey: migrationKey)

        // Refresh from server
        await refreshFromServer(userId: userId)
    }

    func refreshFromServer(userId: UUID) async {
        guard let serverItems = try? await BagService.shared.fetchBagItems(userId: userId) else {
            return
        }
        items = serverItems
        save() // Keep local cache in sync
    }

    private func queueSync() {
        guard let userId = AuthService.shared.currentUserId else { return }

        syncTask?.cancel()
        syncTask = Task {
            try? await Task.sleep(for: .seconds(1)) // Debounce
            for item in items {
                try? await BagService.shared.syncBagItem(userId: userId, item: item)
            }
        }
    }

    // MARK: - Persistence (UserDefaults)

    private func load() {
        guard let data = defaults.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([BagItem].self, from: data)
        else { return }
        items = decoded
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        defaults.set(data, forKey: storageKey)
    }
}
