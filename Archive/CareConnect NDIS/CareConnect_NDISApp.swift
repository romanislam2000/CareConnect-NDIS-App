//
//  CareConnect_NDISApp.swift
//  CareConnect NDIS
//
//  Created by Md Roman Islam on 14/5/2025.
//

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
                if authVM.userRole == "admin" {
                    AdminView()
                        .environmentObject(authVM)
                } else {
                    MainTabView()
                        .environmentObject(authVM)
                }
            } else {
                LoginView()
                    .environmentObject(authVM)
            }
        }
    }
}
