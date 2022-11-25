//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Yuru Zhou on 11/25/22.
//

import Foundation
import FirebaseDatabase

class DatabaseManager {
    static let database = Database.database().reference()
    
    static func insertUser(user: User) {
        database.child(user.id).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName,
            "email_address": user.emailAddress
        ])
    }
}
