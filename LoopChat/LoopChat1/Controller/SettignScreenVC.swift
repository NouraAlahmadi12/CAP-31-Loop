//
//  SettignScreenVC.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 19/05/1443 AH.
//

import UIKit
import Firebase
class SettignScreenVC: UIViewController {
    
    @IBOutlet weak var darkAndLightMood: UISwitch!
    @IBAction func darkAndLightMoodAction(_ sender: Any) {
        
        if(darkAndLightMood.isOn == true){
            let appView = UIApplication.shared.windows.first
            appView?.overrideUserInterfaceStyle = .light
        }else{
            let appView = UIApplication.shared.windows.first
            appView?.overrideUserInterfaceStyle = .dark
        }
    }
    @IBAction func logoutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        presentLoginScreen()
    }
    
    func presentLoginScreen (){
        self.navigationController?.popToRootViewController(animated: true)
    }    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
