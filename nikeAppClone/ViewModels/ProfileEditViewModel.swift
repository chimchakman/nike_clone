//
//  ProfileEditViewModel.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/21/26.
//

import Foundation

@Observable
final class ProfileEditViewModel {
    // Editable fields
    var firstName: String
    var surname: String
    var hometown: String
    var bio: String

    // State
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    private(set) var isSaved = false

    // Original values (for comparison)
    private let originalFirstName: String
    private let originalSurname: String
    private let originalHometown: String
    private let originalBio: String

    init(profile: UserProfile) {
        self.firstName = profile.firstName
        self.surname = profile.surname
        self.hometown = profile.hometown ?? ""
        self.bio = profile.bio ?? ""

        self.originalFirstName = profile.firstName
        self.originalSurname = profile.surname
        self.originalHometown = profile.hometown ?? ""
        self.originalBio = profile.bio ?? ""
    }

    var hasChanges: Bool {
        firstName != originalFirstName ||
        surname != originalSurname ||
        hometown != originalHometown ||
        bio != originalBio
    }

    var bioCharacterCount: Int {
        bio.count
    }

    var isBioValid: Bool {
        bio.count <= 150
    }

    var canSave: Bool {
        hasChanges &&
        !firstName.isEmpty &&
        !surname.isEmpty &&
        isBioValid &&
        !isLoading
    }

    func updateProfile() async {
        guard let userId = AuthService.shared.currentUserId else { return }
        guard canSave else { return }

        isLoading = true
        errorMessage = nil

        do {
            try await ProfileService.shared.updateProfile(
                userId: userId,
                firstName: firstName != originalFirstName ? firstName : nil,
                surname: surname != originalSurname ? surname : nil,
                hometown: hometown != originalHometown ? hometown : nil,
                bio: bio != originalBio ? bio : nil
            )
            isSaved = true
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
