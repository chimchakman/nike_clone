//
//  BottomTab.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/24/26.
//

import SwiftUI

struct BottomTab: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Image("home")
                Spacer()
                Image("shop")
                Spacer()
                Image("favourites")
                Spacer()
                Image("bag")
                Spacer()
                Image("profile")
                Spacer()
            }
            .padding(.top, 10)
            .padding(.bottom, 18)
            .background(Color.white)
        }
    }
}

#Preview {
    BottomTab()
}
