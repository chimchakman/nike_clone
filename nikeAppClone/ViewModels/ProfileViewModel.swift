//
//  ProfileViewModel.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/20/26.
//

import Foundation

@Observable
final class ProfileViewModel {
    private(set) var userProfile: UserProfile?
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    func loadProfile() async {
        guard let userId = AuthService.shared.currentUserId else {
            errorMessage = "No user logged in"
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            userProfile = try await ProfileService.shared.fetchProfile(userId: userId)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    var fullName: String {
        guard let profile = userProfile else { return "" }
        return "\(profile.firstName) \(profile.surname)"
    }

    var memberSince: String {
        guard let profile = userProfile else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return "Member Since \(formatter.string(from: profile.createdAt))"
    }
}
