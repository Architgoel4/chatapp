//
//  FirebaseManager.swift
//  chatapp
//
//  Created by Goel, Archit on 18/07/18.
//  Copyright © 2018 Goel, Archit. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


class FirebaseManager: NSObject {
    static let databaseRef = Database.database().reference()
    static var currentUserId: String = ""
    static var currentUser: User? = nil
    
    
    static func Login(email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            }
            else{
                currentUserId = (user?.user.uid)!
                currentUser = user?.user
                completion(true)
            }
        }
    }
    
    static func CreateUser(email: String, password: String, username: String, completion: @escaping (_ result: String) -> Void ) {
        Auth.auth().createUser(withEmail: email, password: password, completion: {(user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            else{
                AddUser(username: username, email: email)
                Login(email: email, password: password, completion: { (success: Bool) in
                    if success {
                        print("Login succes after creation")
                    }
                    else {
                        print("Login unsuccess")
                    }
                })
            }
            completion("")
            
        })
    }
    
    static func AddUser(username: String, email: String){
        let uid = Auth.auth().currentUser?.uid
        let post = ["uid": uid,
                    "username": username,
                    "email": email,
                    "profileImageUrl": ""]
        databaseRef.child("users").child(uid!).setValue(post)
    }
    
}
