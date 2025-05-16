import Foundation

struct StorageDocument: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var link: String
}
