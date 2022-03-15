//
//  Constants.swift
//  TwiterClone
//
//  Created by Vitor Henrique Barreiro Marinho on 15/03/22.
//

import UIKit
import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")
let DB_RF = Database.database().reference()
let REF_USERS = DB_RF.child("users")
