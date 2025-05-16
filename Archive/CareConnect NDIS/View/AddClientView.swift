import SwiftUI

struct AddClientView: View {
    @ObservedObject var viewModel: ClientViewModel
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var age = ""
    @State private var contactNumber = ""
    @State private var supportNeeds = ""
    @State private var isActive = true

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.indigo.opacity(0.7), Color.blue.opacity(0.4)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack(spacing: 16) {
                    GroupBox {
                        TextField("Full Name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    HStack(spacing: 12) {
                        GroupBox {
                            TextField("Age", text: $age)
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)

                        GroupBox {
                            TextField("Phone", text: $contactNumber)
                                .keyboardType(.phonePad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                    }

                    GroupBox {
                        TextField("Support Needs", text: $supportNeeds)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    Toggle(isOn: $isActive) {
                        Label("Active Client", systemImage: isActive ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal)
                    .foregroundColor(.white)

                    Spacer()

                    Button(action: addClient) {
                        Label("Add Client", systemImage: "person.crop.circle.badge.plus")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.15))
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                            )
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
            .navigationTitle("New Client")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
    

    func addClient() {
        guard !name.isEmpty, let ageInt = Int(age) else { return }

        let data: [String: Any] = [
            "name": name,
            "age": ageInt,
            "contactNumber": contactNumber,
            "supportNeeds": supportNeeds,
            "isActive": isActive
        ]

        viewModel.addClient(data: data) // ✅ Fixed here
        viewModel.fetchClients()
        dismiss()
    }


}
