//
//  RemoteImage.swift
//  nikeAppClone
//
//  Created by Claude on 2026-02-15.
//

import SwiftUI

struct RemoteImage: View {
    let url: String
    var contentMode: ContentMode = .fit

    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Color.lightGray96
                    ProgressView().tint(.gray)
                }
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .transition(.opacity)
            case .failure:
                ZStack {
                    Color.lightGray96
                    Image(systemName: "photo")
                        .foregroundColor(.gray.opacity(0.5))
                        .font(.system(size: 24))
                }
            @unknown default:
                EmptyView()
            }
        }
        .animation(.easeIn(duration: 0.2), value: url)
    }
}
