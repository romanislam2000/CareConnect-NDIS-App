import Foundation
import FirebaseFirestore

struct Client: Identifiable {
    var id: String
    var name: String
    var age: Int
    var contactNumber: String
    var supportNeeds: String
    var isActive: Bool
    var address: String

    init(id: String, data: [String: Any]) {
        self.id = id
        self.name = data["name"] as? String ?? ""
        self.age = data["age"] as? Int ?? 0
        self.contactNumber = data["contactNumber"] as? String ?? ""
        self.supportNeeds = data["supportNeeds"] as? String ?? ""
        self.isActive = data["isActive"] as? Bool ?? false
        self.address = data["address"] as? String ?? ""
    }
}
