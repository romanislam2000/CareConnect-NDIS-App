import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authVM: AuthViewModel

    init() {
        UITabBar.appearance().backgroundColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor.white.withAlphaComponent(0.6)
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            TabView {
                // Show Clients tab only if user is an admin
                if authVM.userRole == "admin" {
                    ClientsView()
                        .tabItem {
                            Label("Clients", systemImage: "person.3.fill")
                        }
                }

                // Show these tabs to everyone
                ShiftsView()
                    .tabItem {
                        Label("Shifts", systemImage: "calendar.badge.clock")
                    }

                TasksView()
                    .tabItem {
                        Label("Tasks", systemImage: "checkmark.circle")
                    }

                IncidentReportsView()
                    .tabItem {
                        Label("Reports", systemImage: "exclamationmark.triangle.fill")
                    }

                AdminView()
                    .tabItem {
                        Label("Admin", systemImage: "gearshape")
                    }
            }
            .accentColor(.white)
        }
    }
}
