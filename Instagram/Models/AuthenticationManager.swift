//
//  AuthenticationManager.swift
//  Instagram
//
//  Created by Yuru Zhou on 11/26/22.
//

import FirebaseAuth

class AuthenticationManager {
    static func logOut(completion: (Bool) -> Void) {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            completion(true)
        } catch {
            completion(false)
            print(error)
        }
    }
}
