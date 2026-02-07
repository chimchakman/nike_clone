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
                    .fill(Color(hex: "E4E4E4"))
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
                                    .foregroundStyle(selectedCountry == "Country" ? Color(hex: "BABABA") : .black)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Image(systemName: "chevron.down")
                                    .font(.system(size: 10, weight: .medium))
                                    .foregroundStyle(Color(hex: "BABABA"))
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 15)
                            .frame(width: 120)
                            .overlay(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(Color(hex: "CDCDCD"), lineWidth: 1)
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
                            .stroke(Color(hex: "CDCDCD"), lineWidth: 1)
                    )
                }
                .padding(.horizontal, 20)
                .padding(.top, 38)
                .padding(.bottom, 28)
            }

            // Bottom Button
            VStack(spacing: 0) {
                Button(action: {
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
                    onSave(address)
                    dismiss()
                }) {
                    Text("Add Delivery Address")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(isFormValid ? .white : Color(hex: "767676"))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(isFormValid ? .black : Color(hex: "F6F6F6"))
                        .clipShape(RoundedRectangle(cornerRadius: 100))
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(isFormValid ? .black : Color(hex: "F6F6F6"), lineWidth: 1)
                        )
                }
                .disabled(!isFormValid)
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
                    .foregroundStyle(Color(hex: "BABABA"))
            }
            .font(.system(size: 14, weight: .regular))
            .tracking(-0.14)
            .foregroundStyle(.black)
            .padding(.horizontal, 10)
            .padding(.vertical, 15)
            .overlay(
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Color(hex: "CDCDCD"), lineWidth: 1)
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

// MARK: - Color Extension for Hex

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    AddAddressSheet { _ in }
}
