//
//  ProfileEditScreen.swift
//  nikeAppClone
//
//  Created by Sunghyun Kim on 2/21/26.
//

import SwiftUI

struct ProfileEditScreen: View {
    @State private var viewModel: ProfileEditViewModel
    @State private var showError = false
    @Environment(\.dismiss) private var dismiss

    init(profile: UserProfile) {
        self._viewModel = State(initialValue: ProfileEditViewModel(profile: profile))
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            header
                .frame(height: 58)

            ScrollView {
                VStack(spacing: 32) {
                    // Profile Photo Section
                    profilePhotoSection
                        .padding(.top, 32)

                    // Form Fields
                    formFields
                        .padding(.horizontal, 24)
                }
                .padding(.bottom, 32)
            }
        }
        .onChange(of: viewModel.isSaved) { _, isSaved in
            if isSaved {
                dismiss()
            }
        }
        .onChange(of: viewModel.errorMessage) { _, error in
            if error != nil {
                showError = true
            }
        }
        .alert("Error", isPresented: $showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "An unknown error occurred")
        }
    }

    // MARK: - Header

    private var header: some View {
        HStack {
            Button("Cancel") {
                dismiss()
            }
            .font(.system(size: 16))
            .foregroundStyle(.black)

            Spacer()

            Button("Save") {
                Task {
                    await viewModel.updateProfile()
                }
            }
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(viewModel.canSave ? .black : Color.textGray)
            .disabled(!viewModel.canSave)
        }
        .padding(.horizontal, 24)
        .background(Color.white)
    }

    // MARK: - Profile Photo Section

    private var profilePhotoSection: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottomTrailing) {
                Circle()
                    .fill(Color.inputBackground)
                    .frame(width: 140, height: 140)

                // Camera overlay (Edit)
                Circle()
                    .fill(.white)
                    .frame(width: 46, height: 46)
                    .overlay(
                        Image(systemName: "camera.fill")
                            .font(.system(size: 20))
                            .foregroundStyle(.black)
                    )
                    .offset(x: 8, y: 8)
            }

            Text("Edit")
                .font(.system(size: 14))
                .foregroundStyle(.black)
        }
    }

    // MARK: - Form Fields

    private var formFields: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Name Section
            VStack(alignment: .leading, spacing: 8) {
                Text("Name")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.textGray)

                // First Name
                TextField("", text: $viewModel.firstName)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .frame(height: 54)
                    .background(Color.disabledBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.inputBackground, lineWidth: 1)
                    )

                // Surname
                TextField("", text: $viewModel.surname)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .frame(height: 54)
                    .background(Color.disabledBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.inputBackground, lineWidth: 1)
                    )
            }

            // Hometown Section
            VStack(alignment: .leading, spacing: 8) {
                Text("Hometown")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.textGray)

                TextField("Town/City, Country/Region", text: $viewModel.hometown)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .frame(height: 54)
                    .background(Color.disabledBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.inputBackground, lineWidth: 1)
                    )
            }

            // Bio Section
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Bio")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.textGray)

                    Spacer()

                    Text("\(viewModel.bioCharacterCount)/150")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.textGray)
                }

                ZStack(alignment: .topLeading) {
                    TextEditor(text: $viewModel.bio)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(height: 120)
                        .scrollContentBackground(.hidden)
                        .padding(12)
                        .background(Color.disabledBackground)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.inputBackground, lineWidth: 1)
                        )

                    // Placeholder
                    if viewModel.bio.isEmpty {
                        Text("150 characters")
                            .font(.system(size: 16))
                            .foregroundColor(Color.textGray.opacity(0.5))
                            .padding(.leading, 16)
                            .padding(.top, 20)
                            .allowsHitTesting(false)
                    }
                }
            }
        }
    }
}
