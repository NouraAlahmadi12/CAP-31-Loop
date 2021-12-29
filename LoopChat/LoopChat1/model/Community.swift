//
//  Community.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 25/05/1443 AH.
//

import Foundation
import FirebaseFirestore
struct Community {
    
    let chatName : String
    let chatID : String
    let chatMember : [DocumentReference] = []
    let Message : [DocumentReference] = []
}
