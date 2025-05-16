import SwiftUI

struct EditIncidentReportView: View {
    @Environment(\.dismiss) var dismiss
    @State var report: IncidentReports
    var onSave: (IncidentReports) -> Void

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.indigo.opacity(0.7), Color.blue.opacity(0.4)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    GroupBox(label: Label("Client Name", systemImage: "person")) {
                        TextField("Client Name", text: $report.clientName)
                            .textFieldStyle(.roundedBorder)
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    GroupBox(label: Label("Date", systemImage: "calendar")) {
                        DatePicker("", selection: $report.date, displayedComponents: .date)
                            .labelsHidden()
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    GroupBox(label: Label("Incident Type", systemImage: "exclamationmark.triangle")) {
                        TextField("Incident Type", text: $report.incidentType)
                            .textFieldStyle(.roundedBorder)
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    GroupBox(label: Label("Description", systemImage: "text.bubble")) {
                        TextEditor(text: $report.description)
                            .frame(height: 100)
                            .cornerRadius(8)
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    GroupBox(label: Label("Reported By", systemImage: "person.crop.circle")) {
                        TextField("Reported By", text: $report.reportedBy)
                            .textFieldStyle(.roundedBorder)
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

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
                            onSave(report)
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
                .navigationTitle("Edit Incident")
            }
        }
    }
}
