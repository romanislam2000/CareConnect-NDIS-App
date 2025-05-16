
import Foundation
import FirebaseFirestore

struct IncidentReports: Identifiable {
    var id: String
    var clientName: String
    var date: Date
    var incidentType: String
    var description: String
    var reportedBy: String

    init(id: String, data: [String: Any]) {
        self.id = id
        self.clientName = data["clientName"] as? String ?? ""
        self.date = (data["date"] as? Timestamp)?.dateValue() ?? Date()
        self.incidentType = data["incidentType"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
        self.reportedBy = data["reportedBy"] as? String ?? ""
    }
}
