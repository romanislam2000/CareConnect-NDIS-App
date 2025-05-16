//
//  AdminViewModel.swift
//  CareConnect NDIS
//
//  Created by Md Roman Islam on 15/5/2025.
//

import Foundation
import FirebaseFirestore

class AdminViewModel: ObservableObject {
    @Published var clientCount = 0
    @Published var shiftCount = 0
    @Published var reportCount = 0
    @Published var documents: [StorageDocument] = []

    private let db = Firestore.firestore()

    func fetchStats() {
        db.collection("clients").getDocuments { snapshot, _ in
            self.clientCount = snapshot?.documents.count ?? 0
        }
        db.collection("shifts").getDocuments { snapshot, _ in
            self.shiftCount = snapshot?.documents.count ?? 0
        }
        db.collection("incidentReports").getDocuments { snapshot, _ in
            self.reportCount = snapshot?.documents.count ?? 0
        }
    }

    func fetchDocuments() {
        db.collection("documents").addSnapshotListener { snapshot, error in
            guard let docs = snapshot?.documents else { return }
            self.documents = docs.compactMap { try? $0.data(as: StorageDocument.self) }
        }
    }

    func addDocument(name: String, link: String) {
        let doc = StorageDocument(name: name, link: link)
        do {
            _ = try db.collection("documents").addDocument(from: doc)
        } catch {
            print("Error saving doc link: \(error)")
        }
    }
}
