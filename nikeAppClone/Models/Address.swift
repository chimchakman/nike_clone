//
//  Address.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/7/26.
//

import Foundation

struct Address: Identifiable, Codable {
    var id: Int?
    var userId: UUID?
    var firstName: String
    var lastName: String
    var addressLine1: String
    var addressLine2: String?
    var postalCode: String
    var city: String
    var country: String
    var phoneNumber: String
    var isDefault: Bool
    var createdAt: Date
    var isDeleted: Bool

    init(
        firstName: String,
        lastName: String,
        addressLine1: String,
        addressLine2: String? = nil,
        postalCode: String,
        city: String,
        country: String,
        phoneNumber: String,
        isDefault: Bool = false
    ) {
        self.id = nil
        self.userId = nil
        self.firstName = firstName
        self.lastName = lastName
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.postalCode = postalCode
        self.city = city
        self.country = country
        self.phoneNumber = phoneNumber
        self.isDefault = isDefault
        self.createdAt = Date()
        self.isDeleted = false
    }

    var fullName: String {
        "\(firstName) \(lastName)"
    }

    var formattedAddress: String {
        if let addressLine2 = addressLine2, !addressLine2.isEmpty {
            return "\(addressLine1), \(addressLine2), \(city), \(country)"
        } else {
            return "\(addressLine1), \(city), \(country)"
        }
    }
}
