//
//  AuthService.swift
//  TwiterClone
//
//  Created by Vitor Henrique Barreiro Marinho on 16/03/22.
//

import UIKit
import Firebase

struct AuthCredentials {
    
    let email: String
    let password: String
    let fullName: String
    let userName: String
    let profileImage: UIImage
    
}


struct AuthService {
    
    static let shared = AuthService()
    
    func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        
    }
    
    
    
    
    
    func registerUser (credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void ) {
        
        let email = credentials.email
        let password = credentials.password
        let userName = credentials.userName
        let fullName = credentials.fullName
        
        guard let imagedata = credentials.profileImage.jpegData(compressionQuality: 0.3) else {return}
        let fileName = NSUUID().uuidString
        let storageref = STORAGE_PROFILE_IMAGES.child(fileName)
        
        storageref.putData(imagedata, metadata: nil) { meta, error in
            storageref.downloadURL {( url, error) in
                guard let profileImageUrl = url?.absoluteString else {return}
                
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    
                    if let error = error {
                        
                        print ( "DEBUG: Error is \(error.localizedDescription)")
                        
                        return
                    }
                    
                    guard let uid = result?.user.uid else {return}
                    
                    
                    let values = ["email": email,
                                  "username":userName,
                                  "fullname": fullName,
                                  "profileImageUrl": profileImageUrl]
                    
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                    
                    REF_USERS.child(uid).updateChildValues(values) { (error, ref) in
                        
                        
                    }
                    
                }
                
                
            }
        }
        
    }
    
    
    
}





