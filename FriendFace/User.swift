//
//  User.swift
//  FriendFace
//
//  Created by Alex Bonder on 8/16/23.
//

import Foundation

struct User: Codable, Identifiable  {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    var registeredDisplayDate: String {
        registered.formatted(date: .numeric, time: .shortened)
    }
}

struct Friend: Codable, Identifiable {
    let id: String
    let name: String
}
