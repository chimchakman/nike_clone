//
//  selectedScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/27/26.
//

import SwiftUI

struct SelectedScreen: View {
    @Binding var selectedTab: Tab

    @State private var homePath = NavigationPath()
    @State private var shopPath = NavigationPath()
    @State private var favPath = NavigationPath()
    @State private var bagPath = NavigationPath()
    @State private var profilePath = NavigationPath()

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack(path: $homePath) { HomeScreen() }.tag(Tab.home)
            NavigationStack(path: $shopPath) { ShopScreen() }.tag(Tab.shop)
            NavigationStack(path: $favPath) { FavouritesScreen(selectedTab: $selectedTab) }.tag(Tab.favourites)
            NavigationStack(path: $bagPath) { BagScreen() }.tag(Tab.bag)
            NavigationStack(path: $profilePath) { ProfileScreen() }.tag(Tab.profile)
        }
        .toolbar(.hidden, for: .tabBar)
    }
}
