//
//  BottomTabBar.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/24/26.
//

import SwiftUI

struct BottomTabBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            tabButton(tab: .home, image: "home")
            tabButton(tab: .shop, image: "shop")
            tabButton(tab: .favourites, image: "favourites")
            tabButton(tab: .bag, image: "bag")
            tabButton(tab: .profile, image: "profile")
        }
        .padding(.top, 10)
        .padding(.bottom, 18)
        .background(Color.white)
    }
    private func tabButton(tab: Tab, image: String) -> some View {
        Button {
            selectedTab = tab
        } label: {
            Image(image)
                .renderingMode(.template)
                .foregroundStyle(selectedTab == tab ? .black : .gray)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    @Previewable @State var selectedTab: Tab = .home
    BottomTabBar(selectedTab: $selectedTab)
}
