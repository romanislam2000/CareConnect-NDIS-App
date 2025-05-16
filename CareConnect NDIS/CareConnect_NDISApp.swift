import SwiftUI
import Firebase

@main
struct CareConnect_NDISApp: App {
    @StateObject var authVM = AuthViewModel()

    init() {
        FirebaseApp.configure()
        UIView.appearance().tintColor = UIColor.systemIndigo
    }

    var body: some Scene {
        WindowGroup {
            if authVM.isLoggedIn {
                MainTabView()
                    .environmentObject(authVM)
            } else {
                LoginView()
                    .environmentObject(authVM)
            }
        }
    }
}
