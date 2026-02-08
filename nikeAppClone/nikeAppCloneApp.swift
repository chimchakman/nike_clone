//
//  nikeAppCloneApp.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/22/26.
//

import SwiftUI

@main
struct nikeAppCloneApp: App {
    @StateObject private var auth = AuthState()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(auth)
        }
    }
}
