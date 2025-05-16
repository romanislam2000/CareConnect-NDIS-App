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
                Color(red: 13/255, green: 152/255, blue: 186/255) // #0D98BA
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("✏️ Edit Client")
                        .font(.largeTitle.bold())
                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                        .padding(.horizontal)

                    GroupBox(label: Label("Name", systemImage: "person")) {
                        TextField("Name", text: $name)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                    .background(Color(red: 13/255, green: 152/255, blue: 186/255))
                    .cornerRadius(12)
                    .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                    .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                    .padding(.horizontal)

                    GroupBox(label: Label("Contact Number", systemImage: "phone")) {
                        TextField("Contact Number", text: $contactNumber)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                    .background(Color(red: 13/255, green: 152/255, blue: 186/255))
                    .cornerRadius(12)
                    .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                    .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                    .padding(.horizontal)

                    GroupBox(label: Label("Support Needs", systemImage: "heart.text.square")) {
                        TextField("Support Needs", text: $supportNeeds)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                    .background(Color(red: 13/255, green: 152/255, blue: 186/255))
                    .cornerRadius(12)
                    .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                    .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                    .padding(.horizontal)

                    Toggle("Active", isOn: $isActive)
                        .padding(.horizontal)
                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))

                    Spacer()

                    HStack(spacing: 20) {
                        Button("Cancel") {
                            dismiss()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 13/255, green: 152/255, blue: 186/255))
                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                        .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)

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
                        .background(Color(red: 13/255, green: 152/255, blue: 186/255))
                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                        .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
                .onAppear {
                    name = client.name
                    contactNumber = client.contactNumber
                    supportNeeds = client.supportNeeds
                    isActive = client.isActive
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}
