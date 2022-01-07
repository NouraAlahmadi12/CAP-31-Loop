//
//  Community.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 25/05/1443 AH.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
struct Community: Codable {
    var communityName : String
    var communityMember : [DocumentReference]
}
