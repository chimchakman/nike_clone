//
//  RoundedButton.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/30/26.
//

import SwiftUI

enum Icon {
    case left(name: String)
    case right(name: String)

    @ViewBuilder
    var view: some View {
        switch self {
        case .left(let name):
            Image(name)
        case .right(let name):
            Image(name)
        }
    }
}

struct RoundedButton: View {

    enum Theme {
        case white
        case black
    }

    enum Style {
        case solid
        case outline
    }

    let icon: Icon?
    let theme: Theme
    let style: Style
    let disabled: Bool
    let title: String
    let action: () -> Void
    
    private let height: CGFloat = 56
    private let cornerRadius: CGFloat = 28   // height/2 느낌 (캡슐)
    private let borderWidth: CGFloat = 1

    init(
        _ title: String,
        icon: Icon? = nil,
        theme: Theme = .white,
        style: Style = .solid,
        disabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.theme = theme
        self.style = style
        self.disabled = disabled
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            content
                .frame(height: height)
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(borderColor, lineWidth: style == .outline ? borderWidth : 0)
                )
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }
        .disabled(disabled)
        .opacity(disabledOpacity)
        .animation(.easeInOut(duration: 0.15), value: disabled)
    }

    // MARK: - Content

    @ViewBuilder
    private var content: some View {
        HStack(spacing: 10) {
            if case .left? = icon {
                icon?.view
                    .font(.system(size: 18, weight: .semibold))
            }
            Text(title)
                .font(.system(size: 16, weight: .semibold))
            if case .right? = icon {
                icon?.view
                    .font(.system(size: 18, weight: .semibold))
            }
        }
        .frame(maxWidth: .infinity)
        .tint(foregroundColor)
    }

    // MARK: - Colors

    private var backgroundColor: Color {
        if disabled {
            return disabledBackgroundColor
        }

        switch (theme, style) {
        case (.white, .solid):
            return .white
        case (.white, .outline):
            return .white.opacity(0.0001)
        case (.black, .solid):
            return .black
        case (.black, .outline):
            return .white.opacity(0.0001)
        }
    }

    private var foregroundColor: Color {
        if disabled {
            return disabledForegroundColor
        }

        switch (theme, style) {
        case (.white, .solid):
            return .black
        case (.white, .outline):
            return .gray
        case (.black, .solid):
            return .white
        case (.black, .outline):
            return .black
        }
    }

    private var borderColor: Color {
        if disabled {
            return disabledBorderColor
        }

        switch (theme, style) {
        case (.white, .solid):
            return .gray.opacity(0.6)
        case (.white, .outline):
            return .gray.opacity(0.6)
        case (.black, .solid):
            return .clear
        case (.black, .outline):
            return .gray.opacity(0.6)
        }
    }

    // MARK: - Disabled tokens

    private var disabledOpacity: Double {
        1.0
    }

    private var disabledBackgroundColor: Color {
        switch style {
        case .solid:
            return Color.black.opacity(0.06)
        case .outline:
            return .white.opacity(0.0001)
        }
    }

    private var disabledForegroundColor: Color {
        Color.gray.opacity(0.45)
    }

    private var disabledBorderColor: Color {
        style == .outline ? Color.gray.opacity(0.25) : .clear
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 16) {
        // white + solid
        RoundedButton("Join Us", theme: .white, style: .solid) { }
        RoundedButton("Join Us", icon: .right(name: "like"), theme: .white, style: .solid) { }
        RoundedButton("Join Us", icon: .left(name: "like"), theme: .white, style: .solid) { }

        // black + solid
        RoundedButton("Join Us", theme: .black, style: .solid) { }
        RoundedButton("Join Us", icon: .right(name: "like"), theme: .black, style: .solid) { }
        RoundedButton("Join Us", icon: .left(name: "like"), theme: .black, style: .solid) { }

        // outline
        RoundedButton("Join Us", theme: .white, style: .outline) { }
        RoundedButton("Join Us", icon: .right(name: "like"), theme: .black, style: .outline) { }

        // disabled
        RoundedButton("Join Us", theme: .white, style: .solid, disabled: true) { }
        RoundedButton("Join Us", icon: .right(name: "like"), theme: .black, style: .outline, disabled: true) { }
    }
    .padding()
    .background(Color(white: 0.95))
}
