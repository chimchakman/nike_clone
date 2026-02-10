//
//  ProfileService.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/10/26.
//

import Foundation
import Supabase

enum ProfileError: LocalizedError {
    case createFailed(String)
    case fetchFailed(String)
    case updateFailed(String)

    var errorDescription: String? {
        switch self {
        case .createFailed(let message):
            return "Failed to create profile: \(message)"
        case .fetchFailed(let message):
            return "Failed to fetch profile: \(message)"
        case .updateFailed(let message):
            return "Failed to update profile: \(message)"
        }
    }
}

final class ProfileService {
    static let shared = ProfileService()

    private let client = SupabaseManager.shared.client

    private init() {}

    /// Create a new user profile
    func createProfile(
        userId: UUID,
        firstName: String,
        surname: String,
        dateOfBirth: Date,
        emailUpdates: Bool
    ) async throws {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate]

        let profileRequest = CreateProfileRequest(
            id: userId,
            firstName: firstName,
            surname: surname,
            dateOfBirth: dateFormatter.string(from: dateOfBirth),
            emailUpdates: emailUpdates
        )

        do {
            try await client
                .from("profiles")
                .insert(profileRequest)
                .execute()
        } catch {
            throw ProfileError.createFailed(error.localizedDescription)
        }
    }

    /// Fetch user profile by user ID
    func fetchProfile(userId: UUID) async throws -> UserProfile {
        do {
            let response: UserProfile = try await client
                .from("profiles")
                .select()
                .eq("id", value: userId.uuidString)
                .single()
                .execute()
                .value

            return response
        } catch {
            throw ProfileError.fetchFailed(error.localizedDescription)
        }
    }

    /// Update user profile
    func updateProfile(
        userId: UUID,
        firstName: String? = nil,
        surname: String? = nil,
        dateOfBirth: Date? = nil,
        emailUpdates: Bool? = nil
    ) async throws {
        let dateString: String?
        if let dateOfBirth = dateOfBirth {
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withFullDate]
            dateString = dateFormatter.string(from: dateOfBirth)
        } else {
            dateString = nil
        }

        let updateRequest = UpdateProfileRequest(
            firstName: firstName,
            surname: surname,
            dateOfBirth: dateString,
            emailUpdates: emailUpdates
        )

        do {
            try await client
                .from("profiles")
                .update(updateRequest)
                .eq("id", value: userId.uuidString)
                .execute()
        } catch {
            throw ProfileError.updateFailed(error.localizedDescription)
        }
    }
}
