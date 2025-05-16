//
//  IncidentReportViewModel.swift
//  CareConnect NDIS
//
//  Created by Md Roman Islam on 14/5/2025.
//
import Foundation
import FirebaseFirestore

class IncidentReportViewModel: ObservableObject {
    @Published var reports: [IncidentReport] = []
    private var db = Firestore.firestore()

    func fetchReports() {
        db.collection("incidentReports").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            guard let docs = snapshot?.documents else { return }
            self.reports = docs.compactMap { try? $0.data(as: IncidentReport.self) }
        }
    }

    func addReport(_ report: IncidentReport) {
        do {
            _ = try db.collection("incidentReports").addDocument(from: report)
        } catch {
            print("Error adding report: \(error)")
        }
    }
}

