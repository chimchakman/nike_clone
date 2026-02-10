//
//  SignUpFormScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/8/26.
//

import SwiftUI

struct SignUpFormScreen: View {
    @State private var email: String = ""
    @State private var showDetailsScreen = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
            // Main background
            Color.white
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Safari-like navigation bar
                safariNavigationBar

                // Main content
                ScrollView {
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

                        // Form section
                        formSection
                    }
                    .padding(.horizontal, 36)
                }

                Spacer()

                // Bottom tab bar
                bottomTabBar
            }
        }
        .ignoresSafeArea()
        .navigationDestination(isPresented: $showDetailsScreen) {
            SignUpDetailsScreen(email: email)
                .navigationBarBackButtonHidden()
        }
        }
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
                        .foregroundColor(Color(red: 0, green: 122/255, blue: 1))
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
                        .foregroundColor(Color(red: 0, green: 122/255, blue: 1))
                        .frame(width: 24, height: 24)
                }
            }
            .frame(height: 58)
            .padding(.horizontal, 16)
            .background(
                Color(red: 249/255, green: 249/255, blue: 249/255, opacity: 0.94)
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

    // MARK: - Form Section

    private var formSection: some View {
        VStack(alignment: .leading, spacing: 42) {
            // Heading
            Text("Enter your email to join us or sign in.")
                .font(.system(size: 28, weight: .regular))
                .foregroundColor(.black)
                .tracking(-0.7)
                .lineSpacing(31 - 28) // Line height 1.1 approximation
                .fixedSize(horizontal: false, vertical: true)

            // Country selector
            HStack(spacing: 0) {
                Text("United States")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 118/255, green: 118/255, blue: 118/255))

                Spacer()

                Button {
                    // Change country action
                    // TODO: Implement country picker
                } label: {
                    Text("Change")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .underline()
                }
            }
            .padding(.top, -20) // Adjust spacing to match 22px from design

            // Email input field
            TextField("Email address", text: $email)
                .font(.system(size: 16))
                .foregroundColor(.black)
                .padding(.horizontal, 16)
                .frame(height: 54)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color(red: 118/255, green: 118/255, blue: 118/255), lineWidth: 1)
                )
                .disableAutocorrection(true)
                .textContentType(.emailAddress)

            // Agreement text
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Text("By continuing, I agree to Nike's")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 118/255, green: 118/255, blue: 118/255))

                    Button {
                        // Open privacy policy
                        // TODO: Add privacy policy link
                    } label: {
                        Text("Privacy Policy")
                            .font(.system(size: 16))
                            .foregroundColor(Color(red: 118/255, green: 118/255, blue: 118/255))
                            .underline()
                    }
                }

                HStack(spacing: 4) {
                    Text("and")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 118/255, green: 118/255, blue: 118/255))

                    Button {
                        // Open terms of use
                        // TODO: Add terms of use link
                    } label: {
                        Text("Terms of Use.")
                            .font(.system(size: 16))
                            .foregroundColor(Color(red: 118/255, green: 118/255, blue: 118/255))
                            .underline()
                    }
                }
            }

            // Next button
            RoundedButton("Next", theme: .black, disabled: email.isEmpty, action: {
                showDetailsScreen = true
            })
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
    SignUpFormScreen()
}
