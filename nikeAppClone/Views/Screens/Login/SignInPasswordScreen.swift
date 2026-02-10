//
//  SignInPasswordScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/10/26.
//

import SwiftUI

struct SignInPasswordScreen: View {
    let email: String
    @Binding var isSheetPresented: Bool

    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var isLoading: Bool = false
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var auth: AuthState

    var body: some View {
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
        .alert("Sign In Error", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
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
            // Heading with email
            VStack(alignment: .leading, spacing: 8) {
                Text("What's your password?")
                    .font(.system(size: 28, weight: .regular))
                    .foregroundColor(.black)
                    .tracking(-0.7)
                    .lineSpacing(31 - 28)
                    .fixedSize(horizontal: false, vertical: true)

                Text(email)
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 118/255, green: 118/255, blue: 118/255))
            }

            // Password input field with toggle
            ZStack(alignment: .trailing) {
                Group {
                    if showPassword {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                }
                .font(.system(size: 16))
                .foregroundColor(.black)
                .padding(.horizontal, 16)
                .padding(.trailing, 40) // Make room for eye icon
                .frame(height: 54)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color(red: 118/255, green: 118/255, blue: 118/255), lineWidth: 1)
                )
                .disableAutocorrection(true)
                .textContentType(.password)
                .autocapitalization(.none)

                // Show/hide password button
                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 118/255, green: 118/255, blue: 118/255))
                        .frame(width: 40, height: 54)
                }
                .padding(.trailing, 8)
            }

            // Forgot password link
            Button {
                // TODO: Implement forgot password flow
            } label: {
                Text("Forgot password?")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .underline()
            }
            .padding(.top, -20)

            // Sign In button
            Button {
                Task {
                    await signIn()
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(Color.black)
                        .frame(height: 48)

                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Sign In")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
                }
            }
            .disabled(password.isEmpty || isLoading)
            .opacity((password.isEmpty || isLoading) ? 0.5 : 1.0)
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

    // MARK: - Sign In Logic

    private func signIn() async {
        isLoading = true

        do {
            let userId = try await AuthService.shared.signIn(email: email, password: password)

            // Success - trigger authentication state before closing sheet
            await MainActor.run {
                isLoading = false
                auth.loginSucceeded()
                // Close the sheet by setting isPresented to false
                isSheetPresented = false
            }
        } catch {
            await MainActor.run {
                isLoading = false
                errorMessage = error.localizedDescription
                showError = true
            }
        }
    }
}

#Preview {
    @State var isSheetPresented = true
    return SignInPasswordScreen(email: "test@example.com", isSheetPresented: $isSheetPresented)
}
