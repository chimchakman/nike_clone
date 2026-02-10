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
    let dateOfBirth: Date
    let emailUpdates: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case surname
        case dateOfBirth = "date_of_birth"
        case emailUpdates = "email_updates"
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
