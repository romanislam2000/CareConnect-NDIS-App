import SwiftUI

struct AdminView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject private var viewModel = AdminViewModel()
    @State private var docName = ""
    @State private var docLink = ""

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.indigo.opacity(0.7), Color.blue.opacity(0.4)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {

                        Text("📁 Shared Documents")
                            .font(.title2.bold())
                            .foregroundColor(.white)

                        ForEach(viewModel.documents) { doc in
                            if let url = URL(string: doc.link) {
                                Link(doc.name, destination: url)
                                    .padding(.vertical, 4)
                                    .lineLimit(1)
                                    .foregroundColor(.white)
                                    .underline()
                            }
                        }

                        Divider().background(Color.white.opacity(0.3)).padding(.vertical)

                        Text("Upload Document")
                            .font(.headline)
                            .foregroundColor(.white)

                        GroupBox {
                            TextField("Document Name", text: $docName)
                                .textFieldStyle(.roundedBorder)
                        }
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)

                        GroupBox {
                            TextField("Document Link", text: $docLink)
                                .textFieldStyle(.roundedBorder)
                        }
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)

                        Button("Upload") {
                            viewModel.uploadDocument(name: docName, link: docLink)
                            docName = ""
                            docLink = ""
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.15))
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                        .cornerRadius(10)

                        Divider().background(Color.white.opacity(0.3)).padding(.vertical)

                        Button("Log Out", role: .destructive) {
                            authVM.logout()
                        }
                        .padding(.top)
                        .foregroundColor(.red)
                    }
                    .padding()
                }
            }
            .navigationTitle("Admin Dashboard")
            .onAppear {
                viewModel.fetchDocuments()
            }
        }
    }
}
