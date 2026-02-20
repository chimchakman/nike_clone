//
//  ProfileScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 1/27/26.
//

import SwiftUI

struct ProfileScreen: View {
    @State private var viewModel = ProfileViewModel()
    @State private var showEditProfile = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if viewModel.isLoading {
                    ProgressView()
                        .padding(.top, 100)
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .padding()
                } else {
                    // Profile Header
                    profileHeader
                        .padding(.horizontal, 24)
                        .padding(.top, 24)

                    // Icon Menu Bar
                    iconMenuBar
                        .padding(.top, 24)

                    Divider()
                        .padding(.top, 24)

                    // Inbox Section
                    navigationRow(
                        title: "Inbox",
                        subtitle: "View message"
                    )
                    .padding(.horizontal, 24)
                    .padding(.top, 24)

                    Divider()
                        .padding(.horizontal, 24)

                    // Nike Member Rewards Section
                    navigationRow(
                        title: "Your Nike Member Rewards",
                        subtitle: "2 available"
                    )
                    .padding(.horizontal, 24)

                    Divider()
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)

                    // Following Section
                    followingSection
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)

                    // Member Since Footer
                    memberSinceFooter
                }
            }
        }
        .task {
            await viewModel.loadProfile()
        }
        .fullScreenCover(isPresented: $showEditProfile, onDismiss: {
            Task {
                await viewModel.loadProfile()
            }
        }) {
            if let profile = viewModel.userProfile {
                ProfileEditScreen(profile: profile)
            }
        }
    }

    // MARK: - Profile Header

    private var profileHeader: some View {
        VStack(spacing: 16) {
            // Avatar with camera overlay
            ZStack(alignment: .bottomTrailing) {
                Circle()
                    .fill(Color(hex: "#E4E4E4"))
                    .frame(width: 84, height: 84)

                Circle()
                    .fill(.white)
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: "camera.fill")
                            .font(.system(size: 14))
                            .foregroundStyle(.black)
                    )
                    .offset(x: 4, y: 4)
            }

            // Name
            Text(viewModel.fullName)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.black)

            // Edit Profile Button
            RoundedButton(
                "Edit Profile",
                theme: .white,
                style: .outline
            ) {
                showEditProfile = true
            }
        }
    }

    // MARK: - Icon Menu Bar

    private var iconMenuBar: some View {
        HStack(spacing: 0) {
            iconMenuItem(icon: "archivebox", label: "Orders")
            verticalDivider
            iconMenuItem(icon: "person.text.rectangle", label: "Pass")
            verticalDivider
            iconMenuItem(icon: "calendar", label: "Events")
            verticalDivider
            iconMenuItem(icon: "gearshape", label: "Settings")
        }
        .padding(.horizontal, 24)
    }

    private func iconMenuItem(icon: String, label: String) -> some View {
        Button(action: {}) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundStyle(.black)

                Text(label)
                    .font(.system(size: 12))
                    .foregroundStyle(Color(hex: "#767676"))
            }
            .frame(maxWidth: .infinity)
        }
    }

    private var verticalDivider: some View {
        Rectangle()
            .fill(Color(hex: "#E4E4E4"))
            .frame(width: 1)
            .frame(maxHeight: .infinity)
    }

    // MARK: - Navigation Row

    private func navigationRow(title: String, subtitle: String) -> some View {
        Button(action: {}) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.black)

                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundStyle(Color(hex: "#767676"))
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundStyle(Color(hex: "#767676"))
            }
            .padding(.vertical, 16)
        }
    }

    // MARK: - Following Section

    private var followingSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Following (3)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.black)

                Spacer()

                Button(action: {}) {
                    Text("Edit")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: "#767676"))
                }
            }

            HStack(spacing: 8) {
                Image("image-30")
                    .frame(width: 108, height: 108)
                Image("image-33")
                    .frame(width: 108, height: 108)
                Image("image-36")
                    .frame(width: 108, height: 108)
                Spacer()
            }
        }
    }

    // MARK: - Member Since Footer

    private var memberSinceFooter: some View {
        Text(viewModel.memberSince)
            .font(.system(size: 12))
            .foregroundStyle(Color(hex: "#767676"))
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 24)
            .background(Color(hex: "#F6F6F6"))
    }
}

#Preview {
    ProfileScreen()
}
