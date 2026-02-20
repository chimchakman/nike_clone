//
//  RootView.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/8/26.
//

import SwiftUI

struct RootView: View {
    @Environment(\.authState) private var auth

    var body: some View {
        Group {
            if auth.isLoggedIn {
                ContentView()
            } else {
                LoginScreen()
            }
        }
    }
}
