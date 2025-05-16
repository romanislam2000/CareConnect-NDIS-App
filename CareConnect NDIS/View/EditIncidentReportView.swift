import SwiftUI

struct EditIncidentReportView: View {
    @Environment(\.dismiss) var dismiss
    @State var report: IncidentReports
    var onSave: (IncidentReports) -> Void

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0/255, green: 35/255, blue: 102/255) // #002366
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("🛠 Edit Incident Report")
                        .font(.largeTitle.bold())
                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                        .padding(.horizontal)

                    GroupBox(label: Label("Client Name", systemImage: "person")) {
                        TextField("Client Name", text: $report.clientName)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                    .background(Color(red: 0/255, green: 35/255, blue: 102/255))
                    .cornerRadius(12)
                    .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                    .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                    .padding(.horizontal)

                    GroupBox(label: Label("Date", systemImage: "calendar")) {
                        DatePicker("", selection: $report.date, displayedComponents: .date)
                            .labelsHidden()
                    }
                    .padding()
                    .background(Color(red: 0/255, green: 35/255, blue: 102/255))
                    .cornerRadius(12)
                    .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                    .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                    .padding(.horizontal)

                    GroupBox(label: Label("Incident Type", systemImage: "exclamationmark.triangle")) {
                        TextField("Incident Type", text: $report.incidentType)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                    .background(Color(red: 0/255, green: 35/255, blue: 102/255))
                    .cornerRadius(12)
                    .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                    .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                    .padding(.horizontal)

                    GroupBox(label: Label("Description", systemImage: "text.bubble")) {
                        TextEditor(text: $report.description)
                            .frame(height: 100)
                            .cornerRadius(8)
                    }
                    .padding()
                    .background(Color(red: 0/255, green: 35/255, blue: 102/255))
                    .cornerRadius(12)
                    .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                    .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                    .padding(.horizontal)

                    GroupBox(label: Label("Reported By", systemImage: "person.crop.circle")) {
                        TextField("Reported By", text: $report.reportedBy)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                    .background(Color(red: 0/255, green: 35/255, blue: 102/255))
                    .cornerRadius(12)
                    .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                    .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                    .padding(.horizontal)

                    Spacer()

                    HStack(spacing: 20) {
                        Button("Cancel") {
                            dismiss()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0/255, green: 35/255, blue: 102/255))
                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                        .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)

                        Button("Save") {
                            onSave(report)
                            dismiss()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0/255, green: 35/255, blue: 102/255))
                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                        .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}
