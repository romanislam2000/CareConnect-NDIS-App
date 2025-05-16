import Foundation
import FirebaseFirestore

class ClientViewModel: ObservableObject {
    @Published var clients: [Client] = []
    private let db = Firestore.firestore()

    init() {
        fetchClients()
    }

    func fetchClients() {
        db.collection("clients").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("No clients found.")
                return
            }

            self.clients = documents.map { doc in
                let data = doc.data()
                return Client(id: doc.documentID, data: data)
            }
        }
    }

    func addClient(data: [String: Any]) {
        db.collection("clients").addDocument(data: data) { error in
            if let error = error {
                print("Error adding client: \(error.localizedDescription)")
            }
        }
    }

    func updateClient(client: Client, name: String, contactNumber: String, supportNeeds: String, isActive: Bool) {
        let data: [String: Any] = [
            "name": name,
            "contactNumber": contactNumber,
            "supportNeeds": supportNeeds,
            "isActive": isActive
        ]

        db.collection("clients").document(client.id).setData(data, merge: true)
    }
    func deleteClient(_ client: Client) {
        db.collection("clients").document(client.id).delete { error in
            if let error = error {
                print("Error deleting client: \(error.localizedDescription)")
            } else {
                print("Client deleted successfully")
            }
        }
    }
}
