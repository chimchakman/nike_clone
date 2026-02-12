//
//  AuthState.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/8/26.
//

import SwiftUI
import Observation

@MainActor
@Observable
final class AuthState {
    var isLoggedIn: Bool = false

    func loginSucceeded() {
        isLoggedIn = true
    }

    func logout() {
        isLoggedIn = false
    }
}

// Environment key for AuthState
struct AuthStateKey: EnvironmentKey {
    @MainActor static let defaultValue = AuthState()
}

extension EnvironmentValues {
    var authState: AuthState {
        get { self[AuthStateKey.self] }
        set { self[AuthStateKey.self] = newValue }
    }
}
