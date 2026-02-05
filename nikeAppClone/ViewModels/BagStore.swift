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

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        load()
    }

    // MARK: - Public API

    func add(productId: String, size: String, quantity: Int = 1) {
        if let index = items.firstIndex(where: {
            $0.productId == productId && $0.size == size
        }) {
            items[index].quantity += quantity
        } else {
            items.append(BagItem(productId: productId, size: size, quantity: quantity))
        }
        save()
    }

    func remove(itemId: String) {
        items.removeAll { $0.id == itemId }
        save()
    }

    func updateQuantity(itemId: String, quantity: Int) {
        guard let index = items.firstIndex(where: { $0.id == itemId }) else { return }
        if quantity <= 0 {
            items.remove(at: index)
        } else {
            items[index].quantity = quantity
        }
        save()
    }

    func clear() {
        items.removeAll()
        save()
    }

    var totalItemCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }

    var isEmpty: Bool {
        items.isEmpty
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
