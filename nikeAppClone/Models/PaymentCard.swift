//
//  PaymentCard.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/7/26.
//

import Foundation

struct PaymentCard: Identifiable, Codable {
    let id: Int?
    var userId: UUID?
    var cardNumber: String
    var cardholderName: String
    var expiryDate: String
    var cvv: String
    var cardType: CardType
    var lastFourDigits: String?
    var isDefault: Bool
    var createdAt: Date
    var isDeleted: Bool

    init(
        id: Int? = nil,
        userId: UUID? = nil,
        cardNumber: String,
        cardholderName: String,
        expiryDate: String,
        cvv: String,
        cardType: CardType = .visa,
        lastFourDigits: String? = nil,
        isDefault: Bool = false,
        createdAt: Date = Date(),
        isDeleted: Bool = false
    ) {
        self.id = id
        self.userId = userId
        self.cardNumber = cardNumber
        self.cardholderName = cardholderName
        self.expiryDate = expiryDate
        self.cvv = cvv
        self.cardType = cardType
        self.lastFourDigits = lastFourDigits
        self.isDefault = isDefault
        self.createdAt = createdAt
        self.isDeleted = isDeleted
    }

    var maskedCardNumber: String {
        if let lastFour = lastFourDigits {
            return "****\(lastFour)"
        }
        // Fallback to current logic
        let digits = cardNumber.filter { $0.isNumber }
        guard digits.count >= 4 else { return cardNumber }
        let lastFour = String(digits.suffix(4))
        let firstThree = String(digits.prefix(3))
        return "\(firstThree)******\(lastFour)"
    }

    enum CardType: String, Codable {
        case visa = "Visa"
        case mastercard = "Mastercard"
        case amex = "American Express"
        case discover = "Discover"
    }
}
