//
//  Shift.swift
//  CareConnect NDIS
//
//  Created by Md Roman Islam on 14/5/2025.
//

import Foundation
import FirebaseFirestoreSwift

struct Shift: Identifiable, Codable {
    @DocumentID var id: String?
    var clientName: String
    var supportWorkerName: String
    var date: Date
    var startTime: String
    var endTime: String
    var notes: String
    var isAttended: Bool
}
