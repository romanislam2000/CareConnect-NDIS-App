import SwiftUI
import FirebaseAuth

struct ClientsView: View {
    @ObservedObject var viewModel = ClientViewModel()
    @State private var searchText = ""
    @State private var selectedClient: Client? = nil

    private var isAdmin: Bool {
        let adminEmails = ["admin@careconnect.com", "admin1@careconnect.com", "md.roman.islam3417@gmail.com"]
        return adminEmails.contains(Auth.auth().currentUser?.email ?? "")
    }

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
                Color(hex: "04953")
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 12) {
                        Text("👥 Clients")
                            .font(.largeTitle.bold())
                            .foregroundColor(Color(hex: "#f8ecc7"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.top, .horizontal])

                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(hex: "#f8ecc7"))
                            TextField("Search", text: $searchText)
                                .foregroundColor(Color(hex: "#f8ecc7"))
                                .placeholder(when: searchText.isEmpty) {
                                    Text("Search")
                                        .foregroundColor(Color(hex: "#f8ecc7").opacity(0.6))
                                }
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(12)
                        .padding(.horizontal)

                        if viewModel.clients.isEmpty {
                            Spacer()
                            ProgressView("Loading clients...")
                                .foregroundColor(Color(hex: "#f8ecc7"))
                                .padding(.top, 50)
                            Spacer()
                        } else {
                            ForEach(filteredClients) { client in
                                VStack(alignment: .leading, spacing: 6) {
                                    HStack {
                                        Text(client.name)
                                            .font(.headline)
                                            .bold()
                                            .foregroundColor(Color(hex: "#f8ecc7"))
                                        Spacer()
                                        if client.isActive {
                                            Text("🟢 Active")
                                                .font(.caption)
                                                .bold()
                                                .foregroundColor(.green)
                                        } else {
                                            Text("🔴 Inactive")
                                                .font(.caption)
                                                .bold()
                                                .foregroundColor(.red)
                                        }
                                    }
                                    Text("📞 \(client.contactNumber)")
                                        .font(.subheadline)
                                        .foregroundColor(Color(hex: "#f8ecc7"))
                                    Text("📝 Needs: \(client.supportNeeds)")
                                        .font(.footnote)
                                        .foregroundColor(Color(hex: "#f8ecc7"))
                                }
                                .padding()
                                .background(Color(red: 0/255, green: 73/255, blue: 83/255))
                                .cornerRadius(14)
                                .shadow(color: Color.black.opacity(0.3), radius: 15, x: 10, y: 10)
                                .shadow(color: Color.white.opacity(0.6), radius: 8, x: -5, y: -5)
                                .padding(.horizontal)
                                .onTapGesture {
                                    if isAdmin {
                                        selectedClient = client
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom, 16)
                }

                // Admin-only Add button
                .toolbar {
                    if isAdmin {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: AddClientView(viewModel: viewModel)) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(Color(hex: "#f8ecc7"))
                            }
                        }
                    }
                }

                // Admin-only Edit sheet
                .sheet(item: $selectedClient) { client in
                    if isAdmin {
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
}

extension View {
    @ViewBuilder
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
