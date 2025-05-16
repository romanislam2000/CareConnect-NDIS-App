import SwiftUI

struct IncidentReportsView: View {
    @StateObject private var viewModel = IncidentReportViewModel()
    @State private var showNewReport = false
    @State private var showEditReport = false
    @State private var selectedReport: IncidentReports?

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.indigo.opacity(0.7), Color.blue.opacity(0.4)]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()

                VStack {
                    if viewModel.reports.isEmpty {
                        Spacer()
                        ProgressView("Loading reports...")
                            .foregroundColor(.white)
                        Spacer()
                    } else {
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
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                                .onTapGesture {
                                    selectedReport = report
                                    showEditReport = true
                                }
                            }
                        }
                        .listStyle(InsetGroupedListStyle())
                    }
                }
                .navigationTitle("🚨 Incident Reports")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showNewReport = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.white)
                        }
                    }
                }
                .sheet(isPresented: $showNewReport) {
                    AddIncidentReportView(viewModel: viewModel)
                }
                .sheet(isPresented: $showEditReport) {
                    if let report = selectedReport {
                        EditIncidentReportView(report: report) { updated in
                            viewModel.updateReport(updated)
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchReports()
                }
                .padding()
            }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
