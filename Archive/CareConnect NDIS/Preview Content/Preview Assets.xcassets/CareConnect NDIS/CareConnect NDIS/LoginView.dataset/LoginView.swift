//
//  LoginView.swift
//  CareConnect NDIS
//
//  Created by Md Roman Islam on 15/5/2025.
//
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel

    @State private var email = ""
    @State private var password = ""
    @State private var showSignup = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("CareConnect NDIS")
                    .font(.largeTitle.bold())
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                if let error = authVM.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Button("Login") {
                    authVM.login(email: email, password: password)
                }
                .buttonStyle(.borderedProminent)

                Button("Don't have an account? Sign Up") {
                    showSignup = true
                }
                .font(.footnote)
                .sheet(isPresented: $showSignup) {
                    SignupView()
                        .environmentObject(authVM)
                }
            }
            .padding()
            .navigationTitle("Login")
        }
    }
}

