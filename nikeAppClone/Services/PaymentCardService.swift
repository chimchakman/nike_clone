//
//  PaymentCardService.swift
//  nikeAppClone
//
//  Created by Claude on 2/14/26.
//

import Foundation
import Supabase

enum PaymentCardError: LocalizedError {
    case fetchFailed(String)
    case saveFailed(String)
    case updateFailed(String)
    case deleteFailed(String)

    var errorDescription: String? {
        switch self {
        case .fetchFailed(let message):
            return "Failed to fetch payment cards: \(message)"
        case .saveFailed(let message):
            return "Failed to save payment card: \(message)"
        case .updateFailed(let message):
            return "Failed to update payment card: \(message)"
        case .deleteFailed(let message):
            return "Failed to delete payment card: \(message)"
        }
    }
}

final class PaymentCardService {
    static let shared = PaymentCardService()
    private let client = SupabaseManager.shared.client

    private init() {}

    /// Fetch all payment cards for a user
    func fetchPaymentCards(userId: UUID) async throws -> [PaymentCard] {
        do {
            let cards: [PaymentCard] = try await client
                .from("payment_cards")
                .select()
                .eq("user_id", value: userId.uuidString)
                .eq("is_deleted", value: false)
                .order("is_default", ascending: false)
                .execute()
                .value
            return cards
        } catch {
            throw PaymentCardError.fetchFailed(error.localizedDescription)
        }
    }

    /// Save a new payment card and return the created card with ID
    func savePaymentCard(userId: UUID, card: PaymentCard) async throws -> PaymentCard {
        do {
            var mutableCard = card
            mutableCard.userId = userId

            // Extract last four digits for storage
            let digits = card.cardNumber.filter { $0.isNumber }
            if digits.count >= 4 {
                mutableCard.lastFourDigits = String(digits.suffix(4))
            }

            let savedCard: PaymentCard = try await client
                .from("payment_cards")
                .insert(mutableCard)
                .select()
                .single()
                .execute()
                .value
            return savedCard
        } catch {
            throw PaymentCardError.saveFailed(error.localizedDescription)
        }
    }

    /// Update an existing payment card
    func updatePaymentCard(cardId: Int, updates: PaymentCard) async throws {
        do {
            try await client
                .from("payment_cards")
                .update(updates)
                .eq("id", value: cardId)
                .execute()
        } catch {
            throw PaymentCardError.updateFailed(error.localizedDescription)
        }
    }

    /// Delete a payment card (soft delete)
    func deletePaymentCard(cardId: Int) async throws {
        do {
            try await client
                .from("payment_cards")
                .update(["is_deleted": true])
                .eq("id", value: cardId)
                .execute()
        } catch {
            throw PaymentCardError.deleteFailed(error.localizedDescription)
        }
    }

    /// Set a payment card as default (and unset others)
    func setDefaultCard(userId: UUID, cardId: Int) async throws {
        do {
            // First, unset all defaults for this user
            try await client
                .from("payment_cards")
                .update(["is_default": false])
                .eq("user_id", value: userId.uuidString)
                .execute()

            // Then set the selected card as default
            try await client
                .from("payment_cards")
                .update(["is_default": true])
                .eq("id", value: cardId)
                .execute()
        } catch {
            throw PaymentCardError.updateFailed(error.localizedDescription)
        }
    }
}
