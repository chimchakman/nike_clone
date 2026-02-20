//
//  UserProfile.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/10/26.
//

import Foundation

struct UserProfile: Codable {
    let id: UUID
    let firstName: String
    let surname: String
    private let dateOfBirthString: String
    let emailUpdates: Bool
    private let createdAtString: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case surname
        case dateOfBirthString = "date_of_birth"
        case emailUpdates = "email_updates"
        case createdAtString = "created_at"
    }

    var dateOfBirth: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.date(from: dateOfBirthString) ?? Date()
    }

    var createdAt: Date {
        let iso8601Formatter = ISO8601DateFormatter()
        return iso8601Formatter.date(from: createdAtString) ?? Date()
    }
}

struct CreateProfileRequest: Codable {
    let id: UUID
    let firstName: String
    let surname: String
    let dateOfBirth: String
    let emailUpdates: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case surname
        case dateOfBirth = "date_of_birth"
        case emailUpdates = "email_updates"
    }
}

struct UpdateProfileRequest: Codable {
    let firstName: String?
    let surname: String?
    let dateOfBirth: String?
    let emailUpdates: Bool?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case surname
        case dateOfBirth = "date_of_birth"
        case emailUpdates = "email_updates"
    }
}
