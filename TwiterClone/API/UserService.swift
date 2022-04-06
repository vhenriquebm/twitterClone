//
//  UserService.swift
//  TwiterClone
//
//  Created by Vitor Henrique Barreiro Marinho on 04/04/22.
//

import Firebase


struct UserService {
    static let shared = UserService()
    
    func fetchUser () {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
            
            guard let username = dictionary["username"] as? String else {return}
            
          print ("DEBUG: Snapshot \(snapshot)")
            
            let user = User(uid: uid, dictionary: dictionary)
        }
        
    }
    
}
