import SwiftUI

struct EditIncidentReportView: View {
    @Environment(\.dismiss) var dismiss
    @State var report: IncidentReports
    var onSave: (IncidentReports) -> Void

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.red.opacity(0.7), Color.purple.opacity(0.4)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 22) {
                    Spacer().frame(height: 10)

                    GroupBox(label: Label("Client Name", systemImage: "person").font(.headline)) {
                        TextField("Client Name", text: $report.clientName)
                            .textFieldStyle(.roundedBorder)
                            .font(.system(size: 18))
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    GroupBox(label: Label("Date", systemImage: "calendar").font(.headline)) {
                        DatePicker("", selection: $report.date, displayedComponents: .date)
                            .labelsHidden()
                            .font(.system(size: 18))
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    GroupBox(label: Label("Incident Type", systemImage: "exclamationmark.triangle").font(.headline)) {
                        TextField("Incident Type", text: $report.incidentType)
                            .textFieldStyle(.roundedBorder)
                            .font(.system(size: 18))
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    GroupBox(label: Label("Description", systemImage: "text.bubble").font(.headline)) {
                        TextEditor(text: $report.description)
                            .frame(height: 120)
                            .font(.system(size: 17))
                            .cornerRadius(8)
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    GroupBox(label: Label("Reported By", systemImage: "person.crop.circle").font(.headline)) {
                        TextField("Reported By", text: $report.reportedBy)
                            .textFieldStyle(.roundedBorder)
                            .font(.system(size: 18))
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
            }
            .navigationTitle("Edit Incident Report")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
