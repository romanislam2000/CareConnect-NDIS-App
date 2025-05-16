//
//  StorageDocument.swift
//  CareConnect NDIS
//
//  Created by Md Roman Islam on 15/5/2025.
//
import Foundation
import FirebaseFirestoreSwift

struct StorageDocument: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var link: String
}

