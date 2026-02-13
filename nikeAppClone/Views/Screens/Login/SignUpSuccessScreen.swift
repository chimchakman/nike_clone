//
//  SignUpSuccessScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/8/26.
//

import SwiftUI

struct SignUpSuccessScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.authState) private var auth

    var body: some View {
        ZStack {
            // Main background
            Color.white
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Safari-like navigation bar
                safariNavigationBar

                // Main content
                VStack(alignment: .leading, spacing: 0) {
                    // Nike logo
                    Image("nike-logo")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.black)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70)
                        .padding(.top, 40)
                        .padding(.bottom, 32)

                    // Success message
                    Text("You have been signed in successfully.")
                        .font(.system(size: 28, weight: .regular))
                        .foregroundColor(.black)
                        .tracking(-0.7)
                        .lineSpacing(31 - 28) // Line height 1.1 approximation
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 32)

                    // Continue button
                    RoundedButton("Continue", theme: .black, disabled: false, action: {
                        auth.loginSucceeded()
                        // TODO: Navigate to main app (dismiss entire login flow)
                        // This should pop back to the root or trigger a state change
                        // to show the main TabView instead of the login flow
                        dismiss()
                    })
                }
                .padding(.horizontal, 36)

                Spacer()

                // Bottom tab bar
                bottomTabBar
            }
        }
        .ignoresSafeArea()
    }

    // MARK: - Safari Navigation Bar

    private var safariNavigationBar: some View {
        VStack(spacing: 0) {
            // Navigation controls
            HStack {
                // Cancel button
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(Color.linkBlue)
                        .tracking(-0.408)
                }

                Spacer()

                // Center title
                Text("nike.com")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.black)
                    .tracking(-0.408)

                Spacer()

                // Refresh button
                Button {
                    // Refresh action
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(Color.linkBlue)
                        .frame(width: 24, height: 24)
                }
            }
            .frame(height: 58)
            .padding(.horizontal, 16)
            .background(
                Color.screenBackgroundTranslucent
                    .blur(radius: 10)
            )
            .overlay(
                Rectangle()
                    .fill(Color.black.opacity(0.3))
                    .frame(height: 0.5),
                alignment: .bottom
            )
        }
    }

    // MARK: - Bottom Tab Bar

    private var bottomTabBar: some View {
        VStack(spacing: 0) {
            // Home indicator
            RoundedRectangle(cornerRadius: 2.5)
                .fill(Color.black)
                .frame(width: 135, height: 5)
                .padding(.top, 8)
                .padding(.bottom, 8)
        }
    }
}

#Preview {
    SignUpSuccessScreen()
}
