//
//  ClientsView.swift
//  CareConnect NDIS
//
//  Created by Md Roman Islam on 14/5/2025.
//

import SwiftUI

struct ClientsView: View {
    @StateObject private var viewModel = ClientViewModel()
    @State private var showAddClient = false
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.clients.isEmpty {
                    Spacer()
                    Text("No clients yet 🫥")
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    List {
                        ForEach(filteredClients) { client in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(client.name)
                                    .font(.headline)
                                Text("📞 \(client.contactNumber)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("Needs: \(client.supportNeeds)")
                                    .font(.footnote)
                            }
                            .padding()
                            .background(Color(.secondarySystemGroupedBackground))
                            .cornerRadius(12)
                            .shadow(color: .gray.opacity(0.1), radius: 3, x: 0, y: 1)
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { i in
                                viewModel.deleteClient(filteredClients[i])
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Clients")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddClient.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.accentColor)
                    }
                }
            }
            .searchable(text: $searchText)
            .sheet(isPresented: $showAddClient) {
                AddClientView(viewModel: viewModel)
            }
            .onAppear {
                viewModel.fetchClients()
            }
        }
    }

    var filteredClients: [Client] {
        if searchText.isEmpty {
            return viewModel.clients
        } else {
            return viewModel.clients.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
