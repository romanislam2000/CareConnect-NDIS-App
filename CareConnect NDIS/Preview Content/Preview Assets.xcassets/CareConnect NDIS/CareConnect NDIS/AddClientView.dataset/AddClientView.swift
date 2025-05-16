//
//  AddClientView.swift
//  CareConnect NDIS
//
//  Created by Md Roman Islam on 14/5/2025.
//
import SwiftUI

struct AddClientView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ClientViewModel

    @State private var name = ""
    @State private var age = ""
    @State private var contact = ""
    @State private var needs = ""
    @State private var address = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Client Details")) {
                    TextField("Full Name", text: $name)
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                    TextField("Contact Number", text: $contact)
                        .keyboardType(.phonePad)
                }

                Section(header: Text("Support Info")) {
                    TextField("Support Needs", text: $needs)
                    TextField("Address", text: $address)
                }
            }
            .navigationTitle("Add Client")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newClient = Client(
                            name: name,
                            age: Int(age) ?? 0,
                            contactNumber: contact,
                            supportNeeds: needs,
                            address: address,
                            isActive: true
                        )
                        viewModel.addClient(newClient)
                        dismiss()
                    }
                    .disabled(name.isEmpty || contact.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
}

