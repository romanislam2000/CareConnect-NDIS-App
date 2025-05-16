import Foundation
import FirebaseFirestore

struct Shift: Identifiable {
    var id: String
    var clientName: String
    var supportWorkerName: String
    var date: Date
    var startTime: Date
    var endTime: Date
    var notes: String
    var isAttended: Bool

    init(id: String, data: [String: Any]) {
        self.id = id
        self.clientName = data["clientName"] as? String ?? ""
        self.supportWorkerName = data["supportWorkerName"] as? String ?? ""
        self.date = (data["date"] as? Timestamp)?.dateValue() ?? Date()
        self.startTime = (data["startTime"] as? Timestamp)?.dateValue() ?? Date()
        self.endTime = (data["endTime"] as? Timestamp)?.dateValue() ?? Date()
        self.notes = data["notes"] as? String ?? ""
        self.isAttended = data["isAttended"] as? Bool ?? false
    }
}
