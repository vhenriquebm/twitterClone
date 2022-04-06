//
//  User.swift
//  TwiterClone
//
//  Created by Vitor Henrique Barreiro Marinho on 06/04/22.
//

import Foundation

struct User {
    
    let fullname: String
    let email: String
    let username: String
    let profileImageUrl: String
    let uid: String
    
    
    init (uid:String, dictionary: [String:AnyObject]) {
        self.uid = uid
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
    
}
