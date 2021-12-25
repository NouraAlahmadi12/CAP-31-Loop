//
//  ChatsScreenVC.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 19/05/1443 AH.
//

import UIKit
import Firebase

class ChatsScreenVC: UIViewController {
    
    let settingScreen = SettignScreenVC()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var currentUser = Auth.auth().currentUser
        if (currentUser == nil){
            settingScreen.presentHomeScreen()
        }
        
    }
}
