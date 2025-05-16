import SwiftUI

struct ClientsView: View {
    @ObservedObject var viewModel = ClientViewModel()
    @State private var searchText = ""
    @State private var selectedClient: Client? = nil

    var filteredClients: [Client] {
        if searchText.isEmpty {
            return viewModel.clients
        } else {
            return viewModel.clients.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.supportNeeds.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.indigo.opacity(0.7), Color.blue.opacity(0.4)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack {
                    if viewModel.clients.isEmpty {
                        Spacer()
                        ProgressView("Loading clients...")
                            .foregroundColor(.white)
                        Spacer()
                    } else {
                        List {
                            ForEach(filteredClients) { client in
                                VStack(alignment: .leading, spacing: 6) {
                                    HStack {
                                        Text(client.name)
                                            .font(.headline)
                                            .bold()
                                            .foregroundColor(.primary)
                                        Spacer()
                                        if client.isActive {
                                            Text("🟢 Active")
                                                .font(.caption)
                                                .foregroundColor(.green)
                                        } else {
                                            Text("🔴 Inactive")
                                                .font(.caption)
                                                .foregroundColor(.red)
                                        }
                                    }
                                    Text("📞 \(client.contactNumber)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Text("📝 Needs: \(client.supportNeeds)")
                                        .font(.footnote)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                                .onTapGesture {
                                    selectedClient = client
                                }
                            }
                            .onDelete { indexSet in
                                indexSet.forEach { i in
                                    let client = filteredClients[i]
                                    viewModel.deleteClient(client)
                                }
                            }
                        }
                        .listStyle(InsetGroupedListStyle())
                        .searchable(text: $searchText)
                    }
                }
                .padding(.top, 5)
                .navigationTitle("👥 Clients")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AddClientView(viewModel: viewModel)) {
                            Label("Add", systemImage: "plus.circle.fill")
                                .foregroundColor(.white)
                        }
                    }
                }
                .sheet(item: $selectedClient) { (client: Client) in
                    EditClientView(
                        client: client,
                        viewModel: viewModel,
                        onSave: {
                            viewModel.fetchClients()
                            selectedClient = nil
                        }
                    )
                }
            }
        }
    }
}
