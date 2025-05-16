import SwiftUI

struct AdminView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject private var viewModel = AdminViewModel()
    @State private var docName = ""
    @State private var docLink = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "355E3B") // #008080
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {

                        Text("📁 Shared Documents")
                            .font(.title2.bold())
                            .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))

                        ForEach(viewModel.documents) { doc in
                            if let url = URL(string: doc.link) {
                                Link(destination: url) {
                                    HStack(spacing: 8) {
                                        Image(systemName: "paperclip")
                                            .foregroundColor(.white)
                                        Text(doc.name)
                                            .fontWeight(.semibold)
                                            .lineLimit(1)
                                            .truncationMode(.tail)
                                            .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                                    }
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                                    .background(Color.white.opacity(0.1))
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                    )
                                }
                                .padding(.bottom, 6)
                            }
                        }


                        Divider().background(Color.white.opacity(0.3)).padding(.vertical)

                        Text("Upload Document")
                            .font(.headline)
                            .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))

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
            .navigationTitle("Document Viewcard")
            .onAppear {
                viewModel.fetchDocuments()
            }
        }
    }
}
