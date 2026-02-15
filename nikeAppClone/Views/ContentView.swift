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
    @State var productsViewModel = ProductsViewModel()
    @State var productDetailsViewModel = ProductDetailsViewModel()

    var body: some View {
        VStack(spacing: 0) {
            SelectedScreen(selectedTab: $selectedTab)
            BottomTabBar(selectedTab: $selectedTab)
        }
        .environment(favouriteStore)
        .environment(bagStore)
        .environment(productsViewModel)
        .environment(productDetailsViewModel)
        .task {
            // Get current user ID
            await AuthService.shared.refreshSession()
            guard let userId = AuthService.shared.currentUserId else { return }

            // Trigger one-time migrations
            await bagStore.migrateToSupabase(userId: userId)
            await favouriteStore.migrateToSupabase(userId: userId)

            // Load products from Supabase
            await productsViewModel.loadProducts()
        }
    }
}

#Preview {
    ContentView()
}
