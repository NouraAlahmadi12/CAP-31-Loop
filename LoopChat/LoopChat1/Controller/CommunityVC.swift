//
//  ChatsScreenVC.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 19/05/1443 AH.
//

import UIKit
import Firebase

class CommunityVC: UIViewController {
    
    let userActive = SignupAndLoginVC()
    let userNotActive = SettignScreenVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let currentUser = Auth.auth().currentUser
        if (currentUser != nil){
            userActive.presentChatScreen()
        }else{
            userNotActive.presentHomeScreen()
        }
    }
}
