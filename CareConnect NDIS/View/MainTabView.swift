import SwiftUI

struct MainTabView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor.white.withAlphaComponent(0.6)
    }

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            TabView {
                ClientsView()
                    .tabItem {
                        Label("Clients", systemImage: "person.3.fill")
                    }

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
