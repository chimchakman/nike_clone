//
//  nikeAppCloneApp.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/22/26.
//

import SwiftUI

@main
struct nikeAppCloneApp: App {
    @State private var auth = AuthState()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\EnvironmentValues.authState, auth)
        }
    }
}
