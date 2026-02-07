//
//  PaymentCard.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/7/26.
//

import Foundation

struct PaymentCard: Identifiable, Codable {
    let id: UUID
    var cardNumber: String
    var cardholderName: String
    var expiryDate: String
    var cvv: String
    var cardType: CardType

    init(
        id: UUID = UUID(),
        cardNumber: String,
        cardholderName: String,
        expiryDate: String,
        cvv: String,
        cardType: CardType = .visa
    ) {
        self.id = id
        self.cardNumber = cardNumber
        self.cardholderName = cardholderName
        self.expiryDate = expiryDate
        self.cvv = cvv
        self.cardType = cardType
    }

    var maskedCardNumber: String {
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
