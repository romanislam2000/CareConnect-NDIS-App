import SwiftUI

struct AddIncidentReportView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: IncidentReportViewModel

    @State private var clientName = ""
    @State private var date = Date()
    @State private var incidentType = ""
    @State private var description = ""
    @State private var reportedBy = ""

    let incidentTypes = ["Injury", "Fall", "Aggression", "Refusal of Care", "Medical Emergency", "Other"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Incident Info")) {
                    TextField("Client Name", text: $clientName)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    Picker("Type", selection: $incidentType) {
                        ForEach(incidentTypes, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                        .frame(height: 100)
                }

                Section(header: Text("Reported By")) {
                    TextField("Your Name", text: $reportedBy)
                }
            }
            .navigationTitle("New Incident")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Submit") {
                        let report = IncidentReport(
                            clientName: clientName,
                            date: date,
                            incidentType: incidentType,
                            description: description,
                            reportedBy: reportedBy
                        )
                        viewModel.addReport(report)
                        dismiss()
                    }
                    .disabled(clientName.isEmpty || incidentType.isEmpty || description.isEmpty || reportedBy.isEmpty)
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

