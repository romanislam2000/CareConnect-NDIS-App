import SwiftUI

struct IncidentReportsView: View {
    @StateObject private var viewModel = IncidentReportViewModel()
    @State private var showNewReport = false
    @State private var showEditReport = false
    @State private var selectedReport: IncidentReports? = nil
    @State private var searchText = ""

    var filteredReports: [IncidentReports] {
        if searchText.isEmpty {
            return viewModel.reports
        } else {
            return viewModel.reports.filter {
                $0.clientName.lowercased().contains(searchText.lowercased()) ||
                $0.incidentType.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0/255, green: 49/255, blue: 83/255) // #003153
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 14) {
                        Text("🚨 Incident Reports")
                            .font(.largeTitle.bold())
                            .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                            .padding(.top)
                            .padding(.horizontal)

                        // Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                            TextField("Search", text: $searchText)
                                .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                                .accentColor(.white)
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(12)
                        .padding(.horizontal)

                        if viewModel.reports.isEmpty {
                            ProgressView("Loading reports...")
                                .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                                .padding(.top, 60)
                        } else {
                            ForEach(filteredReports) { report in
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("🚨 \(report.incidentType)")
                                        .font(.headline)
                                        .foregroundColor(.red)

                                    Text("👤 Client: \(report.clientName)")
                                        .font(.subheadline)
                                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))

                                    Text("📅 \(formattedDate(report.date)) by \(report.reportedBy)")
                                        .font(.footnote)
                                        .foregroundColor(.gray)

                                    Text("📝 \(report.description)")
                                        .font(.footnote)
                                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                                        .padding(.top, 4)
                                }
                                .padding()
                                .background(Color(red: 0/255, green: 49/255, blue: 83/255))
                                .cornerRadius(14)
                                .shadow(color: Color.black.opacity(0.3), radius: 15, x: 8, y: 8)
                                .shadow(color: Color.white.opacity(0.3), radius: 6, x: -6, y: -6)
                                .padding(.horizontal)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedReport = report
                                    showEditReport = true
                                }
                            }
                        }
                    }
                    .padding(.bottom, 16)
                }

                // Toolbar Button to Add Report
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showNewReport = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255)) // #f8ecc7
                        }
                    }
                }

                // New Report Sheet
                .sheet(isPresented: $showNewReport) {
                    AddIncidentReportView(viewModel: viewModel)
                }

                // Edit Report Sheet (with ID binding fix)
                .sheet(isPresented: $showEditReport, onDismiss: {
                    selectedReport = nil
                }) {
                    if let report = selectedReport {
                        EditIncidentReportView(report: report) { updated in
                            viewModel.updateReport(updated)
                            showEditReport = false
                            selectedReport = nil
                        }
                    }
                }
                .id(selectedReport?.id) // 🔥 Forces sheet to reload for correct record

                .onAppear {
                    viewModel.fetchReports()
                }
            }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
