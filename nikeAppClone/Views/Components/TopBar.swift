//
//  NavigationBar.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/27/26.
//
import SwiftUI

struct TopBar: View {
    var title: String?
    let buttons: Set<TopBarButton>
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            if let title, !title.isEmpty {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(1)
            }

            HStack {
                if buttons.contains(.back) {
                    Button {
                        dismiss()
                    } label: {
                        Image("vector")
                            .padding(.leading, 20)
                    }
                }

                Spacer()

                HStack(spacing: 8) {
                    if buttons.contains(.settings) {
                        Button(action: {}) {
                            Image("setting")
                                .padding(10)
                        }
                    }
                    if buttons.contains(.search) {
                        Button(action: {}) {
                            Image("magnifyingGlass")
                                .padding(.trailing, 20)
                        }
                    }
                }
            }
        }
        .frame(height: 44)
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }
}

#Preview {
    TopBar(title: "Hello World", buttons: [.back, .settings, .search])
}
