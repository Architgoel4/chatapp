//
//  User.swift
//  chatapp
//
//  Created by Goel, Archit on 19/07/18.
//  Copyright © 2018 Goel, Archit. All rights reserved.
//

import UIKit
import FirebaseStorage

class ChatUser: NSObject {
    var username: String
    var email: String
    var uid: String
    var profileImageUrl: String
    
    init(username: String, email: String, uid: String, profileImageUrl: String) {
        self.username = username
        self.email = email
        self.uid = uid
        self.profileImageUrl = profileImageUrl
    }
    
    func getProfileImage() -> UIImage {
        if let url = URL(string: self.profileImageUrl) {
            if let data = try? Data(contentsOf: url) {
                return UIImage(data: data)!
            }
        }
        return UIImage()
    }
    
    func uploadProfileImage(profileImage: UIImage) {
        let profileImageRef = Storage.storage().reference().child("profileImages").child("\(NSUUID().uuidString).jpg")
        if let imageData = UIImageJPEGRepresentation(profileImage, 0.25) {
            profileImageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                else {
                    profileImageRef.downloadURL(completion: { (downloadURL, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                        else {
                            if self.profileImageUrl == "" {
                                self.profileImageUrl = (downloadURL?.absoluteString)!
                                
                            FirebaseManager.databaseRef.child("users").child(self.uid).updateChildValues(["profileImageUrl": (downloadURL?.absoluteString)!])
                            }
                        }
                    })
                }
            }
        }
    }
}
