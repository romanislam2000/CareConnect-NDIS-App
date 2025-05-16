import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var message = ""
    @State private var error = ""

    var body: some View {
        ZStack {
            Color(hex: "#4b2142")
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 80)

                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(hex: "4b2142"))
                    .shadow(color: Color.black.opacity(0.3), radius: 15, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.6), radius: 8, x: -5, y: -5)
                    .frame(width: 320, height: 250)
                    .overlay(
                        VStack(spacing: 16) {
                            Text("Reset Your Password")
                                .font(.headline)
                                .foregroundColor(.white)

                            TextField("Enter your email", text: $email)
                                .keyboardType(.emailAddress)
                                .textContentType(.emailAddress)
                                .autocapitalization(.none)
                                .padding(14)
                                .background(Color.white)
                                .cornerRadius(10)

                            Button("Send Reset Link") {
                                sendResetLink()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "74226c"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .padding()
                    )

                if !message.isEmpty {
                    Text(message)
                        .foregroundColor(.green)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                if !error.isEmpty {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                Button("Close") {
                    dismiss()
                }
                .padding(.top, 10)
                .foregroundColor(.white.opacity(0.8))

                Spacer()
            }
            .padding()
        }
    }

    func sendResetLink() {
        guard !email.isEmpty else {
            error = "Please enter your email address."
            return
        }

        Auth.auth().sendPasswordReset(withEmail: email) { err in
            if let err = err {
                self.error = "Error: \(err.localizedDescription)"
                self.message = ""
            } else {
                self.message = "A reset link has been sent to your email."
                self.error = ""
            }
        }
    }
}
