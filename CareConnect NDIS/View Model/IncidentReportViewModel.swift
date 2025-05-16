import FirebaseFirestore

class IncidentReportViewModel: ObservableObject {
    @Published var reports: [IncidentReports] = []
    private let db = Firestore.firestore()

    func fetchReports() {
        db.collection("incidentReports")
            .order(by: "date", descending: true)
            .addSnapshotListener { snapshot, error in
                guard let docs = snapshot?.documents else { return }
                self.reports = docs.map {
                    IncidentReports(id: $0.documentID, data: $0.data())
                }
            }
    }


    func addReport(_ data: [String: Any]) {
        db.collection("incidentReports").addDocument(data: data) { error in
            if let error = error {
                print("Error adding incident report: \(error.localizedDescription)")
            }
        }
    }
    func updateReport(_ report: IncidentReports) {
        let data: [String: Any] = [
            "clientName": report.clientName,
            "date": Timestamp(date: report.date),
            "incidentType": report.incidentType,
            "description": report.description,
            "reportedBy": report.reportedBy
        ]
        db.collection("incidentReports").document(report.id).setData(data, merge: true)
    }

}
