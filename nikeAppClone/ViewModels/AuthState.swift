//
//  AuthState.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/8/26.
//

import SwiftUI

@MainActor
final class AuthState: ObservableObject {
    @Published var isLoggedIn: Bool = false

    func loginSucceeded() {
        isLoggedIn = true
    }

    func logout() {
        isLoggedIn = false
    }
}
