// AuthViewModel.swift
import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var userRole: String = ""
    @Published var errorMessage: String?

    private var db = Firestore.firestore()

    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }
            guard let uid = result?.user.uid else { return }

            // Default role assignment for new users (adjust as needed)
            self?.db.collection("users").document(uid).setData([
                "role": "admin"
            ]) { err in
                if let err = err {
                    print("Failed to write user role: \(err.localizedDescription)")
                }
            }

            self?.isLoggedIn = true
            self?.fetchUserRole(uid: uid)
        }
    }

    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }

            guard let uid = result?.user.uid else { return }
            self?.isLoggedIn = true
            self?.fetchUserRole(uid: uid)
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
            self.userRole = ""
        } catch {
            print("Logout error: \(error.localizedDescription)")
        }
    }

    func fetchUserRole(uid: String) {
        db.collection("users").document(uid).getDocument { [weak self] snapshot, error in
            if let data = snapshot?.data(), let role = data["role"] as? String {
                self?.userRole = role
            } else {
                print("Failed to fetch role or role missing")
            }
        }
    }
}
