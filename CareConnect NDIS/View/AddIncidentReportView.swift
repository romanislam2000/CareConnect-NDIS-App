import SwiftUI
import FirebaseFirestore

struct AddIncidentReportView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: IncidentReportViewModel

    @State private var clientName = ""
    @State private var date = Date()
    @State private var incidentType = ""
    @State private var description = ""
    @State private var reportedBy = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 22/255, green: 22/255, blue: 107/255)
                    .ignoresSafeArea()

                VStack(spacing: 18) {
                    Text("📝 New Incident Report")
                        .font(.largeTitle.bold())
                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                    GroupBox(label: Text("Client").font(.caption)) {
                        Menu {
                            ForEach(clientViewModel.clients) { client in
                                Button(action: {
                                    selectedClient = client
                                }) {
                                    Text(client.name)
                                }
                            }
                        } label: {
                            Text(selectedClient?.name ?? "Select Client")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(12)
                                .background(Color(red: 248/255, green: 236/255, blue: 199/255))
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .background(Color(red: 22/255, green: 22/255, blue: 107/255))
                    .cornerRadius(12)
                    .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                    .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                    .padding(.horizontal)

                    Spacer()

                    HStack(spacing: 20) {
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Cancel")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 22/255, green: 22/255, blue: 107/255))
                                .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                                .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                        }

                        Button(action: {
                            let reportData: [String: Any] = [
                                "clientName": clientName,
                                "date": Timestamp(date: date),
                                "incidentType": incidentType,
                                "description": description,
                                "reportedBy": reportedBy
                            ]
                            viewModel.addReport(reportData)
                            dismiss()
                        }) {
                            Text("Save")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 22/255, green: 22/255, blue: 107/255))
                                .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                                .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
            .navigationTitle("New Incident")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                }
            }
        }
    }
}
