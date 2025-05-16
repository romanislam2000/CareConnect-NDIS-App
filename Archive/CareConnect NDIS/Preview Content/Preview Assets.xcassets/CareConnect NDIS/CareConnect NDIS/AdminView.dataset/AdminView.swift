//
//  AdminView.swift
//  CareConnect NDIS
//
//  Created by Md Roman Islam on 15/5/2025.
//

import SwiftUI

struct AdminView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject private var viewModel = AdminViewModel()

    @State private var docName = ""
    @State private var docLink = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Dashboard Cards
                    DashboardCard(title: "Total Clients", value: viewModel.clientCount, icon: "person.3.fill")
                    DashboardCard(title: "Shifts Logged", value: viewModel.shiftCount, icon: "calendar.badge.clock")
                    DashboardCard(title: "Incident Reports", value: viewModel.reportCount, icon: "exclamationmark.bubble")

                    Divider().padding(.vertical)

                    // Add Document Links
                    VStack(alignment: .leading, spacing: 12) {
                        Text("📎 Add Document Link")
                            .font(.title3.bold())

                        TextField("Document Name", text: $docName)
                            .textFieldStyle(.roundedBorder)

                        TextField("Paste URL (e.g. Google Drive, Dropbox)", text: $docLink)
                            .textFieldStyle(.roundedBorder)

                        Button("Save Link") {
                            guard !docName.isEmpty, !docLink.isEmpty else { return }
                            viewModel.addDocument(name: docName, link: docLink)
                            docName = ""
                            docLink = ""
                        }
                        .buttonStyle(.borderedProminent)
                    }

                    Divider()

                    // Show Document Links
                    VStack(alignment: .leading, spacing: 10) {
                        Text("📂 Shared Documents")
                            .font(.title3.bold())

                        ForEach(viewModel.documents) { doc in
                            Link(doc.name, destination: URL(string: doc.link)!)
                                .padding(.vertical, 4)
                                .lineLimit(1)
                        }
                    }

                    Divider()

                    // Logout
                    Button("Log Out", role: .destructive) {
                        authVM.logout()
                    }
                    .padding(.top)
                }
                .padding()
            }
            .navigationTitle("Admin Dashboard")
            .onAppear {
                viewModel.fetchStats()
                viewModel.fetchDocuments()
            }
        }
    }
}
