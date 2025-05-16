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
                Color(hex: "29AB87")
                    .ignoresSafeArea()

                VStack(spacing: 18) {
                    Text("➕ Add New Client")
                        .font(.largeTitle.bold())
                        .foregroundColor(Color(hex: "#f8ecc7"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                    Group {
                        TextField("Full Name", text: $name)
                        TextField("Age", text: $age)
                            .keyboardType(.numberPad)
                        TextField("Phone", text: $contactNumber)
                            .keyboardType(.phonePad)
                        TextField("Support Needs", text: $supportNeeds)
                    }
                    .padding()
                    .background(Color(hex: "#29AB87")) // Container color from ClientsView
                    .cornerRadius(12)
                    .foregroundColor(Color(hex: "#f8ecc7"))
                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                    .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                    .padding(.horizontal)

                    Toggle(isOn: $isActive) {
                        Label("Active Client", systemImage: isActive ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(Color(hex: "#f8ecc7"))
                    }
                    .padding(.horizontal)

                    Spacer()

                    Button(action: addClient) {
                        Label("Add Client", systemImage: "person.crop.circle.badge.plus")
                            .font(.headline)
                            .foregroundColor(Color(hex: "#f8ecc7"))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#29AB87"))
                            .cornerRadius(14)
                            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                            .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
            .navigationTitle("New Client")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Color(hex: "#f8ecc7"))
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

        viewModel.addClient(data: data)
        viewModel.fetchClients()
        dismiss()
    }
}
