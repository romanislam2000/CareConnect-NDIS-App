//
//  TaskLog.swift
//  CareConnect NDIS
//
//  Created by Md Roman Islam on 14/5/2025.
//

import Foundation
import FirebaseFirestoreSwift

struct TaskLog: Identifiable, Codable {
    @DocumentID var id: String?
    var clientName: String
    var date: Date
    var tasksCompleted: [String]
    var notes: String
}
