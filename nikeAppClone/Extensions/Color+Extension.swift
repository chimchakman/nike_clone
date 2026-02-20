//
//  Color+Extension.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/13/26.
//

import SwiftUI

extension Color {
    // MARK: - Hex Initializer

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

    // MARK: - Gray Scale Colors

    /// Light gray for button backgrounds - Color(white: 0.95)
    static let lightGray95 = Color(white: 0.95)

    /// Light gray for item/button backgrounds - Color(white: 0.96)
    static let lightGray96 = Color(white: 0.96)

    /// Light gray for card borders - Color(white: 0.87)
    static let lightGray87 = Color(white: 0.87)

    /// Light gray for general borders - Color(white: 0.9)
    static let lightGray90 = Color(white: 0.9)

    /// Medium gray for inactive text - Color(white: 0.46)
    static let mediumGray = Color(white: 0.46)

    /// Input field background - Color(hex: "E4E4E4")
    static let inputBackground = Color(hex: "E4E4E4")

    /// Placeholder text color - Color(hex: "BABABA")
    static let placeholder = Color(hex: "BABABA")

    /// Border color - Color(hex: "CDCDCD")
    static let border = Color(hex: "CDCDCD")

    /// Disabled text color - Color(hex: "767676")
    static let disabledText = Color(hex: "767676")

    /// Disabled background color - Color(hex: "F6F6F6")
    static let disabledBackground = Color(hex: "F6F6F6")

    /// Gray text - Color(red: 118/255, green: 118/255, blue: 118/255)
    static let textGray = Color(red: 118/255, green: 118/255, blue: 118/255)

    /// Gray stroke - Color(red: 205/255, green: 205/255, blue: 205/255)
    static let strokeGray = Color(red: 205/255, green: 205/255, blue: 205/255)

    // MARK: - Special Colors

    /// Success green - Color(red: 0.13, green: 0.55, blue: 0.13)
    static let successGreen = Color(red: 0.13, green: 0.55, blue: 0.13)

    /// Red card color - Color(red: 0.92, green: 0.15, blue: 0.15)
    static let cardRed = Color(red: 0.92, green: 0.15, blue: 0.15)

    /// Orange card color - Color(red: 0.98, green: 0.56, blue: 0.09)
    static let cardOrange = Color(red: 0.98, green: 0.56, blue: 0.09)

    /// Link blue - Color(red: 0, green: 122/255, blue: 1)
    static let linkBlue = Color(red: 0, green: 122/255, blue: 1)

    /// Screen background - Color(red: 249/255, green: 249/255, blue: 249/255)
    static let screenBackground = Color(red: 249/255, green: 249/255, blue: 249/255)

    /// Translucent screen background - Color(red: 249/255, green: 249/255, blue: 249/255, opacity: 0.94)
    static let screenBackgroundTranslucent = Color(red: 249/255, green: 249/255, blue: 249/255, opacity: 0.94)
}
