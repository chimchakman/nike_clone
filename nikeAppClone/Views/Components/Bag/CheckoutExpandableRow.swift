//
//  CheckoutExpandableRow.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/6/26.
//

import SwiftUI

struct CheckoutExpandableRow: View {
    let title: String
    let actionText: String
    let actionColor: Color
    let subtitle: String?
    let onTap: () -> Void

    init(
        title: String,
        actionText: String,
        actionColor: Color = .black,
        subtitle: String? = nil,
        onTap: @escaping () -> Void
    ) {
        self.title = title
        self.actionText = actionText
        self.actionColor = actionColor
        self.subtitle = subtitle
        self.onTap = onTap
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black)

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text(actionText)
                        .font(.system(size: 16))
                        .foregroundStyle(actionColor)
                        .multilineTextAlignment(.trailing)

                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.system(size: 16))
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                    }
                }

                Image(systemName: "plus")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.black)
                    .padding(.leading, 8)
            }
            .padding(.vertical, 16)
            .contentShape(Rectangle())
            .onTapGesture {
                onTap()
            }

            Divider()
        }
    }
}

#Preview {
    VStack(spacing: 0) {
        CheckoutExpandableRow(
            title: "Delivery",
            actionText: "Select Delivery",
            actionColor: .red,
            onTap: {}
        )

        CheckoutExpandableRow(
            title: "Payment",
            actionText: "Select Payment",
            actionColor: .red,
            onTap: {}
        )

        CheckoutExpandableRow(
            title: "Purchase Summary",
            actionText: "US$10.00",
            actionColor: .black,
            onTap: {}
        )
    }
    .padding(.horizontal, 24)
}
