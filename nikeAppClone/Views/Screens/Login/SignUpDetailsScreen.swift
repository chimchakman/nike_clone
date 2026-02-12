//
//  SignUpDetailsScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/8/26.
//

import SwiftUI

struct SignUpDetailsScreen: View {
    let email: String

    @State private var firstName: String = ""
    @State private var surname: String = ""
    @State private var password: String = ""
    @State private var dateOfBirth: Date = Date()
    @State private var showPassword: Bool = false
    @State private var showDatePicker: Bool = false
    @State private var emailUpdates: Bool = false
    @State private var agreeToTerms: Bool = false
    @State private var showSuccessScreen = false
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var showError = false

    @Environment(\.dismiss) private var dismiss
    @Environment(\.authState) private var auth

    // Password validation
    private var isPasswordLengthValid: Bool {
        password.count >= 8
    }

    private var isPasswordComplexityValid: Bool {
        let hasUppercase = password.range(of: "[A-Z]", options: .regularExpression) != nil
        let hasLowercase = password.range(of: "[a-z]", options: .regularExpression) != nil
        let hasNumber = password.range(of: "[0-9]", options: .regularExpression) != nil
        return hasUppercase && hasLowercase && hasNumber
    }

    private var isFormValid: Bool {
        !firstName.isEmpty &&
        !surname.isEmpty &&
        isPasswordLengthValid &&
        isPasswordComplexityValid &&
        agreeToTerms
    }

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
            .sheet(isPresented: $showDatePicker) {
                datePickerSheet
            }
            .navigationDestination(isPresented: $showSuccessScreen) {
                SignUpSuccessScreen()
                    .navigationBarBackButtonHidden()
            }
            .alert("Error", isPresented: $showError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage ?? "An unknown error occurred")
            }
            .disabled(isLoading)
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
        VStack(alignment: .leading, spacing: 24) {
            // Heading
            Text("Now let's make you a Nike Member.")
                .font(.system(size: 28, weight: .regular))
                .foregroundColor(.black)
                .tracking(-0.7)
                .lineSpacing(31 - 28) // Line height 1.1 approximation
                .fixedSize(horizontal: false, vertical: true)

            // Email confirmation with Edit button
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 4) {
                    Text("Creating account for")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 118/255, green: 118/255, blue: 118/255))

                    Text(email)
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 118/255, green: 118/255, blue: 118/255))

                    Button {
                        // Edit email action
                        dismiss()
                    } label: {
                        Text("Edit")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .underline()
                    }
                }
            }

            // First name and Surname side by side
            HStack(spacing: 16) {
                TextField("First Name", text: $firstName)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .frame(height: 54)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color(red: 118/255, green: 118/255, blue: 118/255), lineWidth: 1)
                    )
                    .textContentType(.givenName)

                TextField("Surname", text: $surname)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .frame(height: 54)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color(red: 118/255, green: 118/255, blue: 118/255), lineWidth: 1)
                    )
                    .textContentType(.familyName)
            }

            // Password field with validation
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    if showPassword {
                        TextField("Password", text: $password)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .textContentType(.newPassword)
                    } else {
                        SecureField("Password", text: $password)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .textContentType(.newPassword)
                    }

                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                            .font(.system(size: 16))
                            .foregroundColor(Color(red: 118/255, green: 118/255, blue: 118/255))
                    }
                }
                .padding(.horizontal, 16)
                .frame(height: 54)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color(red: 118/255, green: 118/255, blue: 118/255), lineWidth: 1)
                )

                // Password validation indicators
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 8) {
                        Image(systemName: isPasswordLengthValid ? "checkmark" : "xmark")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(isPasswordLengthValid ? .green : Color(red: 118/255, green: 118/255, blue: 118/255))

                        Text("Minimum of 8 characters")
                            .font(.system(size: 12))
                            .foregroundColor(isPasswordLengthValid ? .green : Color(red: 118/255, green: 118/255, blue: 118/255))
                    }

                    HStack(spacing: 8) {
                        Image(systemName: isPasswordComplexityValid ? "checkmark" : "xmark")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(isPasswordComplexityValid ? .green : Color(red: 118/255, green: 118/255, blue: 118/255))

                        Text("Uppercase, lowercase letters and one number")
                            .font(.system(size: 12))
                            .foregroundColor(isPasswordComplexityValid ? .green : Color(red: 118/255, green: 118/255, blue: 118/255))
                    }
                }
            }

            // Date of Birth field
            VStack(alignment: .leading, spacing: 8) {
                Button {
                    showDatePicker = true
                } label: {
                    HStack {
                        Text(dateOfBirth, style: .date)
                            .font(.system(size: 16))
                            .foregroundColor(.black)

                        Spacer()

                        Image(systemName: "calendar")
                            .font(.system(size: 16))
                            .foregroundColor(Color(red: 118/255, green: 118/255, blue: 118/255))
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 54)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color(red: 118/255, green: 118/255, blue: 118/255), lineWidth: 1)
                    )
                }

                Text("Get a Nike Member Reward on your birthday.")
                    .font(.system(size: 12))
                    .foregroundColor(Color(red: 118/255, green: 118/255, blue: 118/255))
            }

            // Checkboxes
            VStack(alignment: .leading, spacing: 16) {
                // Email updates checkbox
                HStack(alignment: .top, spacing: 12) {
                    Button {
                        emailUpdates.toggle()
                    } label: {
                        RoundedRectangle(cornerRadius: 6)
                            .strokeBorder(Color(red: 205/255, green: 205/255, blue: 205/255), lineWidth: 1.5)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.white)
                            )
                            .overlay(
                                Image(systemName: "checkmark")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.black)
                                    .opacity(emailUpdates ? 1 : 0)
                            )
                            .frame(width: 20, height: 20)
                    }

                    Text("Sign up for emails to get updates from Nike on products, offers and your Member benefits.")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .fixedSize(horizontal: false, vertical: true)
                }

                // Terms and privacy checkbox
                HStack(alignment: .top, spacing: 12) {
                    Button {
                        agreeToTerms.toggle()
                    } label: {
                        RoundedRectangle(cornerRadius: 6)
                            .strokeBorder(Color(red: 205/255, green: 205/255, blue: 205/255), lineWidth: 1.5)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.white)
                            )
                            .overlay(
                                Image(systemName: "checkmark")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.black)
                                    .opacity(agreeToTerms ? 1 : 0)
                            )
                            .frame(width: 20, height: 20)
                    }
                    
                    VStack (alignment: .leading) {
                        
                        HStack(spacing: 4) {
                            Text("I agree to Nike's")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                            
                            Button {
                                // Open privacy policy
                                // TODO: Add privacy policy link
                            } label: {
                                Text("Privacy Policy")
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                                    .underline()
                            }
                            
                            Text("and")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                        }
                        HStack {
                            Button {
                                // Open terms of use
                                // TODO: Add terms of use link
                            } label: {
                                Text("Terms of Use.")
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                                    .underline()
                            }
                        }
                        .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }

            // Create Account button
            RoundedButton(
                isLoading ? "Creating Account..." : "Create Account",
                theme: .black,
                disabled: !isFormValid || isLoading,
                action: {
                    Task {
                        await createAccount()
                    }
                }
            )
        }
    }

    // MARK: - Date Picker Sheet

    private var datePickerSheet: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button {
                    showDatePicker = false
                } label: {
                    Text("Cancel")
                        .font(.system(size: 17))
                        .foregroundColor(Color(red: 0, green: 122/255, blue: 1))
                }

                Spacer()

                Text("Date of Birth")
                    .font(.system(size: 17, weight: .semibold))

                Spacer()

                Button {
                    showDatePicker = false
                } label: {
                    Text("Done")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(Color(red: 0, green: 122/255, blue: 1))
                }
            }
            .padding()
            .background(Color(red: 249/255, green: 249/255, blue: 249/255))

            // Date Picker
            DatePicker(
                "",
                selection: $dateOfBirth,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .labelsHidden()
            .padding()

            Spacer()
        }
        .presentationDetents([.medium])
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

    // MARK: - Actions

    private func createAccount() async {
        isLoading = true
        errorMessage = nil

        do {
            // Step 1: Sign up the user with email and password
            let userId = try await AuthService.shared.signUp(
                email: email,
                password: password
            )

            // Step 2: Create the user profile
            try await ProfileService.shared.createProfile(
                userId: userId,
                firstName: firstName,
                surname: surname,
                dateOfBirth: dateOfBirth,
                emailUpdates: emailUpdates
            )

            // Success - trigger authentication state before navigation
            await MainActor.run {
                isLoading = false
                auth.loginSucceeded()
                showSuccessScreen = true
            }

        } catch let error as AuthError {
            isLoading = false
            errorMessage = error.localizedDescription
            showError = true
        } catch let error as ProfileError {
            isLoading = false
            errorMessage = error.localizedDescription
            showError = true
        } catch {
            isLoading = false
            errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
            showError = true
        }
    }
}

#Preview {
    SignUpDetailsScreen(email: "test@example.com")
}
