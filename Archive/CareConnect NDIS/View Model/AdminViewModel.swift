import Foundation
import FirebaseFirestore

class AdminViewModel: ObservableObject {
    @Published var documents: [StorageDocument] = []

    private let db = Firestore.firestore()

    func fetchDocuments() {
        db.collection("documents").addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else { return }

            self.documents = snapshot.documents.compactMap { doc in
                let data = doc.data()
                guard let name = data["name"] as? String,
                      let link = data["link"] as? String else {
                    return nil
                }
                return StorageDocument(id: doc.documentID, name: name, link: link)
            }
        }
    }

    func uploadDocument(name: String, link: String) {
        let data: [String: Any] = [
            "name": name,
            "link": link
        ]

        db.collection("documents").addDocument(data: data) { error in
            if let error = error {
                print("❌ Upload error:", error.localizedDescription)
            } else {
                print("✅ Document uploaded.")
            }
        }
    }
}
