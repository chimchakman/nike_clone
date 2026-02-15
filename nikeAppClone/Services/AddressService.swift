//
//  AddressService.swift
//  nikeAppClone
//
//  Created by Claude on 2/14/26.
//

import Foundation
import Supabase

enum AddressError: LocalizedError {
    case fetchFailed(String)
    case saveFailed(String)
    case updateFailed(String)
    case deleteFailed(String)

    var errorDescription: String? {
        switch self {
        case .fetchFailed(let message):
            return "Failed to fetch addresses: \(message)"
        case .saveFailed(let message):
            return "Failed to save address: \(message)"
        case .updateFailed(let message):
            return "Failed to update address: \(message)"
        case .deleteFailed(let message):
            return "Failed to delete address: \(message)"
        }
    }
}

final class AddressService {
    static let shared = AddressService()
    private let client = SupabaseManager.shared.client

    private init() {}

    /// Fetch all addresses for a user
    func fetchAddresses(userId: UUID) async throws -> [Address] {
        do {
            let addresses: [Address] = try await client
                .from("addresses")
                .select()
                .eq("user_id", value: userId.uuidString)
                .eq("is_deleted", value: false)
                .order("is_default", ascending: false)
                .execute()
                .value
            return addresses
        } catch {
            throw AddressError.fetchFailed(error.localizedDescription)
        }
    }

    /// Save a new address
    func saveAddress(userId: UUID, address: Address) async throws {
        do {
            var mutableAddress = address
            mutableAddress.userId = userId

            try await client
                .from("addresses")
                .insert(mutableAddress)
                .execute()
        } catch {
            throw AddressError.saveFailed(error.localizedDescription)
        }
    }

    /// Update an existing address
    func updateAddress(addressId: Int, updates: Address) async throws {
        do {
            try await client
                .from("addresses")
                .update(updates)
                .eq("id", value: addressId)
                .execute()
        } catch {
            throw AddressError.updateFailed(error.localizedDescription)
        }
    }

    /// Delete an address (soft delete)
    func deleteAddress(addressId: Int) async throws {
        do {
            try await client
                .from("addresses")
                .update(["is_deleted": true])
                .eq("id", value: addressId)
                .execute()
        } catch {
            throw AddressError.deleteFailed(error.localizedDescription)
        }
    }

    /// Set an address as default (and unset others)
    func setDefaultAddress(userId: UUID, addressId: Int) async throws {
        do {
            // First, unset all defaults for this user
            try await client
                .from("addresses")
                .update(["is_default": false])
                .eq("user_id", value: userId.uuidString)
                .execute()

            // Then set the selected address as default
            try await client
                .from("addresses")
                .update(["is_default": true])
                .eq("id", value: addressId)
                .execute()
        } catch {
            throw AddressError.updateFailed(error.localizedDescription)
        }
    }
}
