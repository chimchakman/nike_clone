//
//  PaymentSuccessView.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/7/26.
//

import SwiftUI

struct PaymentSuccessView: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            VStack {
                Spacer()

                // Green Checkmark Circle
                ZStack {
                    Circle()
                        .stroke(Color.successGreen, lineWidth: 4)
                        .frame(width: 80, height: 80)

                    Image(systemName: "checkmark")
                        .font(.system(size: 40, weight: .semibold))
                        .foregroundStyle(Color.successGreen)
                }

                Spacer()

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
        }
    }
}

#Preview {
    PaymentSuccessView()
}
