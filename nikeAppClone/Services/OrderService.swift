//
//  OrderService.swift
//  nikeAppClone
//
//  Created by Claude on 2026-02-15.
//

import Foundation
import Supabase

enum OrderError: LocalizedError {
    case notAuthenticated
    case emptyCart
    case invalidData
    case createOrderFailed(String)
    case createOrderItemsFailed(String)
    case rollbackFailed(String)

    var errorDescription: String? {
        switch self {
        case .notAuthenticated:
            return "You must be logged in to place an order."
        case .emptyCart:
            return "Your cart is empty. Please add items before checkout."
        case .invalidData:
            return "Invalid order data. Please try again."
        case .createOrderFailed(let message):
            return "Failed to create order: \(message)"
        case .createOrderItemsFailed(let message):
            return "Failed to create order items: \(message)"
        case .rollbackFailed(let message):
            return "Critical error during rollback: \(message)"
        }
    }
}

class OrderService {
    static let shared = OrderService()

    private init() {}

    /// Creates a new order with items in a transaction-like manner
    /// - Parameters:
    ///   - userId: The user ID
    ///   - addressId: The delivery address ID
    ///   - paymentCardId: The payment card ID
    ///   - items: Array of order item creation data
    ///   - totalAmount: Total order amount
    /// - Returns: The created Order
    func createOrder(
        userId: String,
        addressId: Int,
        paymentCardId: Int,
        items: [OrderItemCreate],
        totalAmount: Decimal
    ) async throws -> Order {
        guard !items.isEmpty else {
            throw OrderError.emptyCart
        }

        // Step 1: Create the order record
        let orderCreate = OrderCreate(
            userId: userId,
            addressId: addressId,
            paymentCardId: paymentCardId,
            totalAmount: totalAmount,
            status: .pending
        )

        let createdOrder: Order
        do {
            createdOrder = try await SupabaseManager.shared.client
                .from("orders")
                .insert(orderCreate)
                .select()
                .single()
                .execute()
                .value
        } catch {
            throw OrderError.createOrderFailed(error.localizedDescription)
        }

        // Step 2: Create order items with the generated order ID
        var orderItemsToInsert: [OrderItemInsert] = []
        for item in items {
            orderItemsToInsert.append(OrderItemInsert(
                orderId: createdOrder.id,
                productId: item.productId,
                size: item.size,
                quantity: item.quantity,
                priceAtPurchase: item.priceAtPurchase
            ))
        }

        do {
            let _: [OrderItem] = try await SupabaseManager.shared.client
                .from("order_items")
                .insert(orderItemsToInsert)
                .select()
                .execute()
                .value
        } catch {
            // Rollback: Mark the order as deleted
            await rollbackOrder(orderId: createdOrder.id)
            throw OrderError.createOrderItemsFailed(error.localizedDescription)
        }

        return createdOrder
    }

    /// Soft deletes an order (rollback mechanism)
    private func rollbackOrder(orderId: Int) async {
        do {
            let _: Order = try await SupabaseManager.shared.client
                .from("orders")
                .update(["is_deleted": true])
                .eq("id", value: orderId)
                .select()
                .single()
                .execute()
                .value
        } catch {
            print("⚠️ Rollback failed for order \(orderId): \(error)")
        }
    }
}
