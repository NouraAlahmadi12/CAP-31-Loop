//
//  User.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 25/05/1443 AH.
//

import Foundation
import FirebaseFirestore
struct User {
    let uid : String
    let userName : String
    let email : String
    let mood : Bool
    let chat : DocumentReference
}

