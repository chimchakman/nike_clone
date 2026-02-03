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
    private(set) var favouriteIDs: Set<String> = []
    private let defaults: UserDefaults
    private let storageKey = "favourite_product_ids"

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        load()
    }

    func isFavourite(_ productID: String) -> Bool {
        favouriteIDs.contains(productID)
    }

    func toggle(_ productID: String) {
        if favouriteIDs.contains(productID) {
            favouriteIDs.remove(productID)
        } else {
            favouriteIDs.insert(productID)
        }
        save()
    }

    // MARK: - Persistence (UserDefaults)

    private func load() {
        let array = defaults.stringArray(forKey: storageKey) ?? []
        favouriteIDs = Set(array)
    }

    private func save() {
        defaults.set(Array(favouriteIDs), forKey: storageKey)
    }

    func removeAll() {
        favouriteIDs.removeAll()
        save()
    }
}
