//
//  Client.swift
//  CareConnect NDIS
//
//  Created by Md Roman Islam on 14/5/2025.
//

import Foundation
import FirebaseFirestoreSwift

struct Client: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var age: Int
    var contactNumber: String
    var supportNeeds: String
    var address: String
    var isActive: Bool
}
