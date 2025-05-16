
import SwiftUI

struct AdminTabView: View {
    var body: some View {
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
                    Label("Tasks", systemImage: "checkmark.rectangle")
                }

            IncidentReportsView()
                .tabItem {
                    Label("Incidents", systemImage: "exclamationmark.bubble")
                }

            AdminView()
                .tabItem {
                    Label("Admin", systemImage: "gearshape.fill")
                }
        }
    }
}
