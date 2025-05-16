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
                LinearGradient(gradient: Gradient(colors: [Color.indigo.opacity(0.7), Color.blue.opacity(0.4)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack(spacing: 16) {
                    GroupBox {
                        TextField("Client Name", text: $clientName)
                            .textFieldStyle(.roundedBorder)
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    GroupBox {
                        DatePicker("Date", selection: $date, displayedComponents: .date)
                            .labelsHidden()
                            .datePickerStyle(.compact)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    GroupBox {
                        TextField("Incident Type", text: $incidentType)
                            .textFieldStyle(.roundedBorder)
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    GroupBox {
                        TextEditor(text: $description)
                            .frame(height: 80)
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    GroupBox {
                        TextField("Reported By", text: $reportedBy)
                            .textFieldStyle(.roundedBorder)
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    Spacer()

                    HStack(spacing: 20) {
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Cancel")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white.opacity(0.15))
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                )
                                .cornerRadius(10)
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
                                .background(Color.white.opacity(0.15))
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                )
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("New Incident")
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
}
