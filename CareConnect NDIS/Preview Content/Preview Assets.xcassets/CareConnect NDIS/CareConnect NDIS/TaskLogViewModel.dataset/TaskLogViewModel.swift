//
//  TaskLogViewModel.swift
//  CareConnect NDIS
//
//  Created by Md Roman Islam on 14/5/2025.
//
import Foundation
import FirebaseFirestore

class TaskLogViewModel: ObservableObject {
    @Published var taskLogs: [TaskLog] = []
    private var db = Firestore.firestore()

    func fetchLogs() {
        db.collection("taskLogs").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            guard let docs = snapshot?.documents else { return }
            self.taskLogs = docs.compactMap { try? $0.data(as: TaskLog.self) }
        }
    }

    func addLog(_ log: TaskLog) {
        do {
            _ = try db.collection("taskLogs").addDocument(from: log)
        } catch {
            print("Error adding log: \(error)")
        }
    }
}

