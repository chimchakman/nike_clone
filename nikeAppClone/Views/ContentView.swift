//
//  ContentView.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/22/26.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .home
    @State var favouriteStore = FavouriteStore()
    @State var bagStore = BagStore()
    var body: some View {
        VStack(spacing: 0) {
            SelectedScreen(selectedTab: $selectedTab)
            BottomTabBar(selectedTab: $selectedTab)
        }
        .environment(favouriteStore)
        .environment(bagStore)
    }
}

#Preview {
    ContentView()
}
