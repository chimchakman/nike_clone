//
//  ContentView.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/22/26.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .home
    var favouriteStore = FavouriteStore()
    var body: some View {
        VStack(spacing: 0) {
            SelectedScreen(selectedTab: $selectedTab)
            BottomTabBar(selectedTab: $selectedTab)
        }
        .environment(favouriteStore)
    }
}

#Preview {
    ContentView()
}
