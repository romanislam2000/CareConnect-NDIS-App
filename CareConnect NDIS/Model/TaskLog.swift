
import Foundation
import FirebaseFirestore

struct TaskLog: Identifiable {
    var id: String
    var clientName: String
    var date: Date
    var tasksCompleted: [String]
    var notes: String

    init(id: String, data: [String: Any]) {
        self.id = id
        self.clientName = data["clientName"] as? String ?? ""
        self.date = (data["date"] as? Timestamp)?.dateValue() ?? Date()
        self.tasksCompleted = data["tasksCompleted"] as? [String] ?? []
        self.notes = data["notes"] as? String ?? ""
    }
}
