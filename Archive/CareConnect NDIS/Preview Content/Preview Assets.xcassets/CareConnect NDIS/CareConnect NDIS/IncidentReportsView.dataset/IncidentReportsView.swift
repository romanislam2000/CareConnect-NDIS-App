import SwiftUI

struct IncidentReportsView: View {
    @StateObject private var viewModel = IncidentReportViewModel()
    @State private var showNewReport = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.reports) { report in
                    VStack(alignment: .leading, spacing: 6) {
                        Text("🚨 \(report.incidentType)")
                            .font(.headline)
                            .foregroundColor(.red)
                        Text("Client: \(report.clientName)")
                            .font(.subheadline)
                        Text("🗓️ \(formattedDate(report.date)) by \(report.reportedBy)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text("📝 \(report.description)")
                            .font(.body)
                            .padding(.top, 4)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                }
            }
            .navigationTitle("Incident Reports")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewReport = true
                    } label: {
                        Image(systemName: "exclamationmark.bubble.fill")
                    }
                }
            }
            .onAppear {
                viewModel.fetchReports()
            }
            .sheet(isPresented: $showNewReport) {
                AddIncidentReportView(viewModel: viewModel)
            }
        }
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

