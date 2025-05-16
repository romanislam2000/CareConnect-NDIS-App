//
//  AuthViewModel.swift
//  CareConnect NDIS
//
//  Created by Md Roman Islam on 15/5/2025.
//
import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String?

    init() {
        self.isLoggedIn = Auth.auth().currentUser != nil
    }

    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.isLoggedIn = true
            }
        }
    }

    func signup(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.isLoggedIn = true
            }
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

