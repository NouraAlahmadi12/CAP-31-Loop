//
//  User.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 25/05/1443 AH.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User :Codable{
    let uid : String
    let userName : String
//    let userType : UserType
    let email : String?
    
    func getDate()->[String:Any] {
        return ["Name User":userName,"Email User":email,"ID User":uid]
    }
}

//enum UserType : Int, Codable {
//    case admin = 1
//    case developer = 2
//}

