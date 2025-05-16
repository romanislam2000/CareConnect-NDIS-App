//
//  ShiftViewModel.swift
//  CareConnect NDIS
//
//  Created by Md Roman Islam on 14/5/2025.
//

import Foundation
import FirebaseFirestore

class ShiftViewModel: ObservableObject {
    @Published var shifts: [Shift] = []
    private let db = Firestore.firestore()

    func fetchShifts() {
        db.collection("shifts").order(by: "date").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            self.shifts = documents.compactMap { try? $0.data(as: Shift.self) }
        }
    }

    func addShift(_ shift: Shift) {
        do {
            _ = try db.collection("shifts").addDocument(from: shift)
        } catch {
            print("Error adding shift: \(error)")
        }
    }

    func markAttendance(for shift: Shift) {
        guard let id = shift.id else { return }
        db.collection("shifts").document(id).updateData([
            "isAttended": true
        ])
    }
}
