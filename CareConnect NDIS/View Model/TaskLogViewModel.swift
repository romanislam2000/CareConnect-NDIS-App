import FirebaseFirestore

class TaskLogViewModel: ObservableObject {
    @Published var taskLogs: [TaskLog] = []
    private let db = Firestore.firestore()

    func fetchLogs() {
        db.collection("taskLogs")
            .order(by: "date", descending: true)
            .addSnapshotListener { snapshot, error in
                guard let docs = snapshot?.documents else { return }
                self.taskLogs = docs.map {
                    TaskLog(id: $0.documentID, data: $0.data())
                }
            }
    }

    func addLog(_ data: [String: Any]) {
        db.collection("taskLogs").addDocument(data: data) { error in
            if let error = error {
                print("Error adding task log: \(error.localizedDescription)")
            }
        }
    }

    func updateLog(_ log: TaskLog) {
        let data: [String: Any] = [
            "clientName": log.clientName,
            "date": Timestamp(date: log.date),
            "tasksCompleted": log.tasksCompleted,
            "notes": log.notes
        ]
        db.collection("taskLogs").document(log.id).setData(data, merge: true)
    }
}
