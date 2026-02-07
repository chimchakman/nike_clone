//
//  Address.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/7/26.
//

import Foundation

struct Address: Identifiable, Codable {
    let id: UUID
    var firstName: String
    var lastName: String
    var addressLine1: String
    var addressLine2: String
    var postalCode: String
    var city: String
    var country: String
    var phoneNumber: String

    init(
        id: UUID = UUID(),
        firstName: String,
        lastName: String,
        addressLine1: String,
        addressLine2: String = "",
        postalCode: String,
        city: String,
        country: String,
        phoneNumber: String
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.postalCode = postalCode
        self.city = city
        self.country = country
        self.phoneNumber = phoneNumber
    }

    var fullName: String {
        "\(firstName) \(lastName)"
    }

    var formattedAddress: String {
        if addressLine2.isEmpty {
            return "\(addressLine1), \(city), \(country)"
        } else {
            return "\(addressLine1), \(addressLine2), \(city), \(country)"
        }
    }
}
