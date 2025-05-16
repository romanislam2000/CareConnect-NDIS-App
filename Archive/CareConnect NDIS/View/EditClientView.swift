import SwiftUI

struct EditClientView: View {
    var client: Client
    @ObservedObject var viewModel: ClientViewModel
    var onSave: () -> Void

    @Environment(\.dismiss) var dismiss

    @State private var name: String = ""
    @State private var contactNumber: String = ""
    @State private var supportNeeds: String = ""
    @State private var isActive: Bool = true

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.indigo.opacity(0.7), Color.blue.opacity(0.4)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    GroupBox(label: Label("Name", systemImage: "person")) {
                        TextField("Name", text: $name)
                            .textFieldStyle(.roundedBorder)
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    GroupBox(label: Label("Contact Number", systemImage: "phone")) {
                        TextField("Contact Number", text: $contactNumber)
                            .textFieldStyle(.roundedBorder)
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    GroupBox(label: Label("Support Needs", systemImage: "heart.text.square")) {
                        TextField("Support Needs", text: $supportNeeds)
                            .textFieldStyle(.roundedBorder)
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    Toggle("Active", isOn: $isActive)
                        .padding(.horizontal)
                        .foregroundColor(.white)

                    Spacer()

                    HStack(spacing: 20) {
                        Button("Cancel") {
                            dismiss()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.15))
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button("Save") {
                            viewModel.updateClient(
                                client: client,
                                name: name,
                                contactNumber: contactNumber,
                                supportNeeds: supportNeeds,
                                isActive: isActive
                            )
                            onSave()
                            dismiss()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.15))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .padding()
                .navigationTitle("Edit Client")
                .onAppear {
                    name = client.name
                    contactNumber = client.contactNumber
                    supportNeeds = client.supportNeeds
                    isActive = client.isActive
                }
            }
        }
    }
}
