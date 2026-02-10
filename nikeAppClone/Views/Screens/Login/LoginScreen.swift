import SwiftUI

struct LoginScreen: View {
    @State private var showAlert = false
    @State private var showSignUpForm = false
    @State private var showSignInForm = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                backgroundLayer

                // Content
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 392)

                    contentLayer


                    buttonsLayer
                        .padding(.top, 80)

                    Spacer()

                    homeIndicator
                        .padding(.bottom, 8)
                }
                .padding(.horizontal, 24)

            }
            .ignoresSafeArea()
            .alert("\"Nike\" Wants to Use \"nike.com\" to Sign In",
                   isPresented: $showAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Continue") {
                    showSignUpForm = true
                    showAlert = false
                }
            } message: {
                Text("This allows the app and website to share information about you.")
            }
            .sheet(isPresented: $showSignUpForm) {
                SignUpFormScreen()
                    .presentationDetents([.large], selection: .constant(.large))
            }
            .sheet(isPresented: $showSignInForm) {
                SignInFormScreen(isPresented: $showSignInForm)
                    .presentationDetents([.large], selection: .constant(.large))
            }
        }
    }

    // MARK: - Background Layer

    private var backgroundLayer: some View {
        ZStack {
            Image("loginBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // Top gradient overlay
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.6),
                    Color.black.opacity(0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 200)
            .frame(maxHeight: .infinity, alignment: .top)

            // Bottom gradient overlay
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0),
                    Color.black.opacity(0.7)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 300)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }

    // MARK: - Content Layer

    private var contentLayer: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Nike logo
            Image("nike-logo")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.white)
                .aspectRatio(contentMode: .fit)
                .frame(width: 70)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 32)

            // Headline text
            Text("Nike App\nBringing Nike Members\nthe best products,\ninspiration and stories\nin sport.")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
                .tracking(-0.168)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    // MARK: - Buttons Layer

    private var buttonsLayer: some View {
        HStack(spacing: 12) {
            // Join Us button
            Button {
                showAlert = true
            } label: {
                Text("Join Us")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.white)
                    .cornerRadius(100)
            }

            // Sign In button
            Button {
                showSignInForm = true
            } label: {
                Text("Sign In")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.white, lineWidth: 1.5)
                    )
            }
        }
    }

    // MARK: - Home Indicator

    private var homeIndicator: some View {
        RoundedRectangle(cornerRadius: 2.5)
            .fill(Color.white.opacity(0.8))
            .frame(width: 135, height: 5)
    }
}

#Preview {
    LoginScreen()
}
