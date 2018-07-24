//
//  ProfileManager.swift
//  chatapp
//
//  Created by Goel, Archit on 19/07/18.
//  Copyright © 2018 Goel, Archit. All rights reserved.
//

import UIKit
import  Firebase
import FirebaseAuth
import FirebaseDatabase

class ProfileManager: NSObject {
    
    static let databaseRef = Database.database().reference()
    static let uid = Auth.auth().currentUser?.uid
    
    static var users = [ChatUser]()
    
    static func getCurrentUser(uid: String) -> ChatUser? {
        if let i = users.index(where: { $0.uid == uid}) {
            return users[i]
        }
        else {
            return nil
        }
    }
    
    static func fillUsers(completion: @escaping() -> Void) {
        users = []
        databaseRef.child("users").observe(.childAdded, with: {
            snapshot in
            print(snapshot)
            if let result = snapshot.value as? [String: AnyObject]{
                let uid = result["uid"] as! String
                let username = result["username"] as! String
                let email = result["email"] as! String
                let profileImageUrl = result["profileImageUrl"] as! String
                
                let u = ChatUser(username: username, email: email, uid: uid, profileImageUrl: profileImageUrl)
                ProfileManager.users.append(u)
            }
            completion()
        })
    }
    
    
}
