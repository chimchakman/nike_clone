//
//  LoginSplashScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/7/26.
//

import SwiftUI

struct LoginSplashScreen: View {
    var body: some View {
        ZStack {
            // Background
            Color.black
                .ignoresSafeArea()

            // Nike Logo
            Image("nike-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 50)

            // Home Indicator
            VStack {
                Spacer()

                RoundedRectangle(cornerRadius: 100)
                    .fill(Color.white)
                    .frame(width: 135, height: 5)
            }
        }
    }
}

#Preview {
    LoginSplashScreen()
}
