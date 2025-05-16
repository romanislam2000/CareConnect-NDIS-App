import FirebaseFirestore

class ShiftViewModel: ObservableObject {
    @Published var shifts: [Shift] = []
    private let db = Firestore.firestore()

    func fetchShifts() {
        db.collection("shifts")
            .order(by: "date")
            .addSnapshotListener { snapshot, error in
                guard let docs = snapshot?.documents else { return }
                self.shifts = docs.map {
                    Shift(id: $0.documentID, data: $0.data())
                }
            }
    }

    func addShift(_ data: [String: Any]) {
        db.collection("shifts").addDocument(data: data) { error in
            if let error = error {
                print("Error adding shift: \(error.localizedDescription)")
            }
        }
    }
    func updateShift(_ shift: Shift) {
        let data: [String: Any] = [
            "clientName": shift.clientName,
            "supportWorkerName": shift.supportWorkerName,
            "date": Timestamp(date: shift.date),
            "startTime": shift.startTime,
            "endTime": shift.endTime,
            "notes": shift.notes,
            "isAttended": shift.isAttended
        ]
        db.collection("shifts").document(shift.id).setData(data, merge: true)
    }

}
