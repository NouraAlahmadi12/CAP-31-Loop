//
//  UserProfileVC.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 21/06/1443 AH.
//

import UIKit
import Firebase
class UserProfileVC: UIViewController {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileUserName: UITextField!
    @IBOutlet weak var profileEmail: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
    }
    
    
    @IBAction func updateUserInfo(_ sender: Any) {
        
        
    }
    func update(){
        let userID = Auth.auth().currentUser?.uid
//        Auth.auth().updateCurrentUser(User) { error in
//            if error == nil{
//
//            }
//        }
        db.collection("Users").document(userID!).updateData(([
            "Name User": profileUserName.text!,
            "Email User": profileEmail.text!
        ])) { error in
            if let error = error{
                print("Error updating document: \(error)")
            }else{
                print("Document successfully updated!")
            }
        }
    }
    
    func getUserData(){
        let userID = Auth.auth().currentUser?.uid
        db.collection("Users").document(userID!).getDocument { [self] snapshot, error in
            let result = snapshot!.data() as! [String: Any]
            let user = User(uid: userID!,
                            userName: result["Name User"] as! String,
                            email: result["Email User"] as! String
            )
            self.profileUserName.text = user.userName
            self.profileEmail.text = user.email
        }
        
    }
}

