import SwiftUI
import FirebaseAuth

struct SignupView: View {
    @EnvironmentObject var authVM: AuthViewModel

    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoading = false
    @State private var isPasswordVisible = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color(hex: "002626")
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 190)

                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(hex: "002626"))
                    .shadow(color: Color.black.opacity(0.3), radius: 15, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.6), radius: 8, x: -5, y: -5)
                    .frame(width: 320, height: 260)
                    .overlay(
                        VStack(spacing: 16) {
                            Text("Create Account")
                                .font(.headline)
                                .foregroundColor(.white)

                            TextField("Email", text: $email)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                .padding(14)
                                .background(Color.white)
                                .cornerRadius(10)

                            ZStack(alignment: .trailing) {
                                Group {
                                    if isPasswordVisible {
                                        TextField("Password", text: $password)
                                    } else {
                                        SecureField("Password", text: $password)
                                    }
                                }
                                .padding(14)
                                .background(Color.white)
                                .cornerRadius(10)

                                Button(action: {
                                    isPasswordVisible.toggle()
                                }) {
                                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 16)
                                }
                            }

                            if !errorMessage.isEmpty {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .font(.footnote)
                                    .multilineTextAlignment(.center)
                            }

                            Button(action: signUp) {
                                if isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color(hex: "0e4547"))
                                        .cornerRadius(10)
                                } else {
                                    Text("Sign Up")
                                        .foregroundColor(Color.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color(hex: "0e4547"))
                                        .cornerRadius(10)
                                }
                            }
                            .disabled(isLoading)
                        }
                        .padding()
                    )
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

    func signUp() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter email and password."
            return
        }

        isLoading = true
        errorMessage = ""

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else {
                    authVM.isLoggedIn = true
                }
            }
        }
    }
}
