import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var userRole: String = ""
    @Published var errorMessage: String?

    private let adminEmails: [String] = [
        "admin@careconnect.com",
        "admin1@careconnect.com"
    ]

    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }

            self?.checkRole(for: email)
            self?.isLoggedIn = true
        }
    }

    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }

            self?.checkRole(for: email)
            self?.isLoggedIn = true
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

    private func checkRole(for email: String) {
        if adminEmails.contains(email.lowercased()) {
            self.userRole = "admin"
        } else {
            self.userRole = "user"
        }
    }
}
