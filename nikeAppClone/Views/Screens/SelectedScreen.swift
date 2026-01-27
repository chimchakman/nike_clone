//
//  selectedScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/27/26.
//

import SwiftUI

struct SelectedScreen: View {
    @Binding var selectedTab: Tab

    var body: some View {
        switch selectedTab {
        case .home:
            NavigationStack { HomeScreen() }
        case .shop:
            NavigationStack { ShopScreen() }
        case .favourites:
            NavigationStack { FavouritesScreen() }
        case .bag:
            NavigationStack { BagScreen() }
        case .profile:
            NavigationStack { ProfileScreen() }
        }
    }
}
