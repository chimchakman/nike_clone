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

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        // cardNumber and cvv are not stored in database (sensitive data)
        case cardholderName = "cardholder_name"
        case expiryDate = "expiry_date"
        case cardType = "card_type"
        case lastFourDigits = "last_four_digits"
        case isDefault = "is_default"
        case createdAt = "created_at"
        case isDeleted = "is_deleted"
    }

    // Custom decoder - cardNumber and cvv are not stored in DB
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.userId = try container.decodeIfPresent(UUID.self, forKey: .userId)
        self.cardNumber = "" // Not stored in database
        self.cardholderName = try container.decode(String.self, forKey: .cardholderName)
        self.expiryDate = try container.decode(String.self, forKey: .expiryDate)
        self.cvv = "" // Not stored in database
        self.cardType = try container.decode(CardType.self, forKey: .cardType)
        self.lastFourDigits = try container.decodeIfPresent(String.self, forKey: .lastFourDigits)
        self.isDefault = try container.decode(Bool.self, forKey: .isDefault)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.isDeleted = try container.decode(Bool.self, forKey: .isDeleted)
    }

    // Custom encoder - cardNumber and cvv are excluded
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(userId, forKey: .userId)
        // cardNumber and cvv are intentionally not encoded
        try container.encode(cardholderName, forKey: .cardholderName)
        try container.encode(expiryDate, forKey: .expiryDate)
        try container.encode(cardType, forKey: .cardType)
        try container.encodeIfPresent(lastFourDigits, forKey: .lastFourDigits)
        try container.encode(isDefault, forKey: .isDefault)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(isDeleted, forKey: .isDeleted)
    }

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
        case visa = "visa"
        case mastercard = "mastercard"
        case amex = "amex"
        case discover = "discover"

        // Display name for UI
        var displayName: String {
            switch self {
            case .visa: return "Visa"
            case .mastercard: return "Mastercard"
            case .amex: return "American Express"
            case .discover: return "Discover"
            }
        }
    }
}
