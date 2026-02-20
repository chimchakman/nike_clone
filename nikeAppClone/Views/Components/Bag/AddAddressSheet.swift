//
//  AddAddressSheet.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/7/26.
//

import SwiftUI

struct AddAddressSheet: View {
    @Environment(\.dismiss) var dismiss

    var onSave: (Address) -> Void

    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var addressLine1: String = ""
    @State private var addressLine2: String = ""
    @State private var postalCode: String = ""
    @State private var city: String = ""
    @State private var selectedCountry: String = "Country"
    @State private var phoneNumber: String = ""
    @State private var showCountryPicker = false
    @State private var isSaving = false
    @State private var showErrorAlert = false
    @State private var errorMessage = ""

    private let countries = ["United States", "Canada", "United Kingdom", "Australia", "Germany", "France", "Japan", "South Korea"]

    // Computed property to check if all required fields are filled
    private var isFormValid: Bool {
        !firstName.isEmpty &&
        !lastName.isEmpty &&
        !addressLine1.isEmpty &&
        !postalCode.isEmpty &&
        !city.isEmpty &&
        selectedCountry != "Country" &&
        !phoneNumber.isEmpty
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Add Delivery Address")
                    .font(.system(size: 16, weight: .medium))
                    .tracking(-0.4)

                Spacer()

                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "minus")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.black)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
            .background(Color.white)
            .overlay(
                Rectangle()
                    .fill(Color.inputBackground)
                    .frame(height: 1),
                alignment: .bottom
            )

            // Form Fields
            ScrollView {
                VStack(spacing: 14) {
                    // First Name
                    FormInputField(placeholder: "First Name", text: $firstName)

                    // Last Name
                    FormInputField(placeholder: "Last Name", text: $lastName)

                    // Address Line 1
                    FormInputField(placeholder: "Address Line 1", text: $addressLine1)

                    // Address Line 2 (Optional)
                    FormInputField(placeholder: "Address Line 2 (Optional)", text: $addressLine2)

                    // Postal Code
                    FormInputField(placeholder: "Postal code", text: $postalCode)

                    // City and Country
                    HStack(spacing: 12) {
                        FormInputField(placeholder: "City", text: $city)

                        // Country Dropdown
                        Menu {
                            ForEach(countries, id: \.self) { country in
                                Button(country) {
                                    selectedCountry = country
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedCountry)
                                    .font(.system(size: 14, weight: .regular))
                                    .tracking(-0.14)
                                    .foregroundStyle(selectedCountry == "Country" ? Color.placeholder : .black)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Image(systemName: "chevron.down")
                                    .font(.system(size: 10, weight: .medium))
                                    .foregroundStyle(Color.placeholder)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 15)
                            .frame(width: 120)
                            .overlay(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(Color.border, lineWidth: 1)
                            )
                        }
                    }

                    // Phone Number
                    FormInputField(placeholder: "Phone Number", text: $phoneNumber)

                    // United States (appears to be pre-filled/display field)
                    HStack {
                        Text("United States")
                            .font(.system(size: 14, weight: .regular))
                            .tracking(-0.14)
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 2)
                            .stroke(Color.border, lineWidth: 1)
                    )
                }
                .padding(.horizontal, 20)
                .padding(.top, 38)
                .padding(.bottom, 28)
            }

            // Bottom Button
            VStack(spacing: 0) {
                Button(action: {
                    Task {
                        await saveAddress()
                    }
                }) {
                    Text(isSaving ? "Saving..." : "Add Delivery Address")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle((isFormValid && !isSaving) ? .white : Color.disabledText)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background((isFormValid && !isSaving) ? .black : Color.disabledBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 100))
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke((isFormValid && !isSaving) ? .black : Color.disabledBackground, lineWidth: 1)
                        )
                }
                .disabled(!isFormValid || isSaving)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            }
            .background(Color.white)

            // Home Indicator
            Color.clear
                .frame(height: 33)
                .overlay(
                    Capsule()
                        .fill(Color.black)
                        .frame(width: 135, height: 5)
                        .padding(.bottom, 8),
                    alignment: .bottom
                )
        }
        .background(Color.white)
        .alert("Error", isPresented: $showErrorAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }

    // MARK: - Save Address

    private func saveAddress() async {
        guard isFormValid else { return }

        isSaving = true

        do {
            // Get current user ID
            let userId = try await AuthService.shared.getCurrentUser()

            // Create address object
            let address = Address(
                firstName: firstName,
                lastName: lastName,
                addressLine1: addressLine1,
                addressLine2: addressLine2,
                postalCode: postalCode,
                city: city,
                country: selectedCountry,
                phoneNumber: phoneNumber
            )

            // Save to Supabase and get back the address with ID
            let savedAddress = try await AddressService.shared.saveAddress(userId: userId, address: address)

            // Success
            await MainActor.run {
                onSave(savedAddress)
                dismiss()
            }

        } catch {
            // Handle error
            await MainActor.run {
                isSaving = false
                errorMessage = error.localizedDescription
                showErrorAlert = true
            }
        }
    }
}

// MARK: - Form Input Field Component

struct FormInputField: View {
    let placeholder: String
    @Binding var text: String

    var body: some View {
        TextField("", text: $text)
            .placeholder(when: text.isEmpty) {
                Text(placeholder)
                    .font(.system(size: 14, weight: .regular))
                    .tracking(-0.14)
                    .foregroundStyle(Color.placeholder)
            }
            .font(.system(size: 14, weight: .regular))
            .tracking(-0.14)
            .foregroundStyle(.black)
            .padding(.horizontal, 10)
            .padding(.vertical, 15)
            .overlay(
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Color.border, lineWidth: 1)
            )
    }
}

// MARK: - View Extension for Placeholder

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    AddAddressSheet { _ in }
}
