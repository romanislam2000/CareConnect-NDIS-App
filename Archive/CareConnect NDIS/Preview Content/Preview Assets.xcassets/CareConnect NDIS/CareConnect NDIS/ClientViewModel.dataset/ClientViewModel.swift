//
//  ClientViewModel.swift
//  CareConnect NDIS
//
//  Created by Md Roman Islam on 14/5/2025.
//
import Foundation
import FirebaseFirestore

class ClientViewModel: ObservableObject {
    @Published var clients: [Client] = []
    private var db = Firestore.firestore()

    func fetchClients() {
        db.collection("clients").order(by: "name").addSnapshotListener { snapshot, error in
            guard let docs = snapshot?.documents else { return }
            self.clients = docs.compactMap { try? $0.data(as: Client.self) }
        }
    }

    func addClient(_ client: Client) {
        do {
            _ = try db.collection("clients").addDocument(from: client)
        } catch {
            print("Error adding client: \(error)")
        }
    }

    func deleteClient(_ client: Client) {
        guard let id = client.id else { return }
        db.collection("clients").document(id).delete()
    }
}

