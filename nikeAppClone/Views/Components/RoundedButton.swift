//
//  RoundedButton.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/30/26.
//

import SwiftUI

struct RoundedButton: View {
    enum Icon {
        case system(name: String)
        case asset(name: String)

        @ViewBuilder
        var view: some View {
            switch self {
            case .system(let name):
                Image(systemName: name)
            case .asset(let name):
                Image(name)
            }
        }
    }

    let title: String
    let icon: Icon?
    let fillColor: Color
    let borderColor: Color
    let textColor: Color
    let height: CGFloat
    let cornerRadius: CGFloat
    let borderWidth: CGFloat
    let isFullWidth: Bool
    let action: () -> Void

    init(
        _ title: String,
        icon: Icon? = nil,
        fillColor: Color = .clear,
        borderColor: Color = .white,
        textColor: Color = .white,
        height: CGFloat = 56,
        cornerRadius: CGFloat = 28,
        borderWidth: CGFloat = 1,
        isFullWidth: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.fillColor = fillColor
        self.borderColor = borderColor
        self.textColor = textColor
        self.height = height
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.isFullWidth = isFullWidth
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                if let icon {
                    icon.view
                        .font(.system(size: 18, weight: .semibold))
                }

            }
            .foregroundStyle(textColor)
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .frame(height: height)
            .contentShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }
        .buttonStyle(.plain)
        .background(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(fillColor)
        )
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(borderColor, lineWidth: borderWidth)
        )
    }
}
