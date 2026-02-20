//
//  AuthService.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/10/26.
//

import Foundation
import Supabase

enum AuthError: LocalizedError {
    case signUpFailed(String)
    case signInFailed(String)
    case signOutFailed(String)
    case invalidSession

    var errorDescription: String? {
        switch self {
        case .signUpFailed(let message):
            return "Sign up failed: \(message)"
        case .signInFailed(let message):
            return "Sign in failed: \(message)"
        case .signOutFailed(let message):
            return "Sign out failed: \(message)"
        case .invalidSession:
            return "No active session found"
        }
    }
}

final class AuthService {
    static let shared = AuthService()

    private let client = SupabaseManager.shared.client
    private var _currentSession: Session?

    private init() {}

    /// Get current user ID synchronously from cached session
    var currentUserId: UUID? {
        _currentSession?.user.id
    }

    /// Sign up a new user with email and password
    func signUp(email: String, password: String) async throws -> UUID {
        do {
            let response = try await client.auth.signUp(
                email: email,
                password: password
            )

            let userId = response.user.id

            return userId
        } catch {
            throw AuthError.signUpFailed(error.localizedDescription)
        }
    }

    /// Sign in with email and password
    func signIn(email: String, password: String) async throws -> UUID {
        do {
            let response = try await client.auth.signIn(
                email: email,
                password: password
            )

            let userId = response.user.id

            return userId
        } catch {
            throw AuthError.signInFailed(error.localizedDescription)
        }
    }

    /// Sign out the current user
    func signOut() async throws {
        do {
            try await client.auth.signOut()
        } catch {
            throw AuthError.signOutFailed(error.localizedDescription)
        }
    }

    /// Get the current user session
    func getCurrentUser() async throws -> UUID {
        do {
            let session = try await client.auth.session
            return session.user.id
        } catch {
            throw AuthError.invalidSession
        }
    }

    /// Refresh and cache the current session for synchronous access
    func refreshSession() async {
        _currentSession = try? await client.auth.session
    }
}
