import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel

    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoading = false
    @State private var showSignup = false
    @State private var animateBubbles = false
    @State private var showForgotPassword = false
    @State private var isPasswordVisible = false
    @AppStorage("savedEmail") private var savedEmail: String = ""
    @AppStorage("savedPassword") private var savedPassword: String = ""
    @AppStorage("isRemembered") private var isRemembered: Bool = false




    var body: some View {
        ZStack {
            Color(hex: "04052e")
                .ignoresSafeArea()

            VStack(spacing: 24) {
                ZStack {
                    animatedBubbleImage("pic1", x: animateBubbles ? -20 : 20, y: animateBubbles ? 20 : -20)
                        .offset(x: -130, y: -20)
                    animatedBubbleImage("pic2", x: animateBubbles ? 18 : -18, y: animateBubbles ? -18 : 18)
                        .offset(x: -60, y: -10)
                    animatedBubbleImage("pic3", x: animateBubbles ? 16 : -16, y: animateBubbles ? 16 : -16)
                        .offset(x: 10, y: 5)
                    animatedBubbleImage("pic4", x: animateBubbles ? -14 : 14, y: animateBubbles ? -14 : 14)
                        .offset(x: 70, y: -15)
                    animatedBubbleImage("pic5", x: animateBubbles ? -12 : 12, y: animateBubbles ? 12 : -12)
                        .offset(x: 120, y: 15)
                    animatedBubbleImage("pic6", x: animateBubbles ? -10 : 10, y: animateBubbles ? -10 : 10)
                        .offset(x: 160, y: -25)
                }
                .frame(height: 70)

                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 1250, height: 200)

                VStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(hex: "04052e"))
                        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 10, y: 10)
                        .shadow(color: Color.white.opacity(0.6), radius: 8, x: -5, y: -5)
                        .frame(width: 320, height: 290)
                        .overlay(
                            VStack(spacing: 16) {
                                TextField("Email", text: $email)
                                    .keyboardType(.emailAddress)
                                    .textContentType(.emailAddress)
                                    .autocapitalization(.none)
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
                                    .textContentType(.password)
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
                                
                                Toggle(isOn: $isRemembered) {
                                    Text("Remember Me")
                                        .font(.footnote)
                                        .foregroundColor(Color(hex: "#f8ecc7"))
                                }
                                .toggleStyle(SwitchToggleStyle(tint: .blue))
                                .padding(.horizontal)


                                Button(action: login) {
                                    if isLoading {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color(red: 47/255, green: 38/255, blue: 121/255))
                                            .cornerRadius(10)
                                    } else {
                                        Text("Login")
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color(red: 47/255, green: 38/255, blue: 121/255))
                                            .cornerRadius(10)
                                    }
                                }
                                .disabled(isLoading)
                                Button(action: {
                                    showForgotPassword = true
                                }) {
                                    Text("Forgot Password?")
                                        .font(.footnote)
                                        .foregroundColor(.red)
                                }
                                .sheet(isPresented: $showForgotPassword) {
                                    ForgotPasswordView()
                                }

                            }
                            .padding()
                        )
                        .padding(.horizontal)
                }

                Button(action: { showSignup = true }) {
                    Text("Don't have an account? Sign Up")
                        .font(.footnote)
                        .foregroundColor(Color(hex: "#f8ecc7").opacity(0.9))
                }
                .sheet(isPresented: $showSignup) {
                    SignupView().environmentObject(authVM)
                }

                ZStack {
                    animatedBubbleImage("pic7", x: animateBubbles ? 20 : -20, y: animateBubbles ? -20 : 20)
                        .offset(x: -130, y: 30)
                    animatedBubbleImage("pic8", x: animateBubbles ? -18 : 18, y: animateBubbles ? 18 : -18)
                        .offset(x: -70, y: 10)
                    animatedBubbleImage("pic9", x: animateBubbles ? 16 : -16, y: animateBubbles ? -16 : 16)
                        .offset(x: 0, y: 0)
                    animatedBubbleImage("pic10", x: animateBubbles ? -14 : 14, y: animateBubbles ? 14 : -14)
                        .offset(x: 60, y: -10)
                    animatedBubbleImage("pic11", x: animateBubbles ? 12 : -12, y: animateBubbles ? -12 : 12)
                        .offset(x: 120, y: 10)
                    animatedBubbleImage("pic12", x: animateBubbles ? 10 : -10, y: animateBubbles ? 10 : -10)
                        .offset(x: 160, y: -15)
                }
                .frame(height: 70)
                .padding(.bottom, 20)
            }
            .onAppear {
                if isRemembered {
                    email = savedEmail
                    password = savedPassword
                }

                withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                    animateBubbles.toggle()
                }
            }

        }
    }

    func animatedBubbleImage(_ imageName: String, x: CGFloat, y: CGFloat) -> some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .offset(x: x, y: y)
            .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: x)
    }

    func login() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in both email and password."
            return
        }

        errorMessage = ""
        isLoading = true

        authVM.login(email: email, password: password)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            if authVM.isLoggedIn {
                if isRemembered {
                    savedEmail = email
                    savedPassword = password
                } else {
                    savedEmail = ""
                    savedPassword = ""
                }
            } else {
                errorMessage = authVM.errorMessage ?? "Login failed."
            }
        }
    }

}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}
