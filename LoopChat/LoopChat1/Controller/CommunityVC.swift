//
//  ChatsScreenVC.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 19/05/1443 AH.
//

import UIKit
import Firebase

class CommunityVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let currentUser = Auth.auth().currentUser
        if (currentUser?.uid == nil ) {
            presentHomeScreen()
        }
    }
    func presentHomeScreen (){
        let viewController = storyboard?.instantiateViewController(withIdentifier: "HomeScreenID") as! SignupAndLoginVC
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.showDetailViewController(viewController, sender: self)
    }
}
