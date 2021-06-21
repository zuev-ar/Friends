//
//  UserModel.swift
//  Friends
//
//  Created by Arkasha Zuev on 16.06.2021.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    
    struct Friend: Codable, Identifiable, Hashable {
        let id: String
        let name: String
    }
    
    let id: String
    let name: String
    let isActive: Bool
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let friends: [Friend]
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy, HH:mm"
        return formatter.string(from: registered)
    }
    
}
