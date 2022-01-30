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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getUserData()
    }
        
    @IBAction func updateUserInfo(_ sender: Any) {
        update()
    }
    
    @IBAction func deleteUserAccount(_ sender: Any) {
        deleteAccount()
    }
    

    func deleteAccount(){
        let userid = Auth.auth().currentUser?.uid
        db.collection("Users").document(userid!).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        let user = Auth.auth().currentUser
        user?.delete { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("successfully deleted ")
                self.presentLoginScreen()
            }
        }
    }
    
    func update(){
        let userID = Auth.auth().currentUser?.uid
        db.collection("Users").document(userID!).updateData(([
            "userName": profileUserName.text!,
            "email": profileEmail.text!
        ])) { error in
            if let error = error{
                print("Error updating document: \(error)")
            }else{
                print("Document successfully updated!")
            }
        }
        let user = Auth.auth().currentUser
        user?.updateEmail(to: profileEmail.text!, completion: { error in
            if error == nil{
                print("successfully updated ")
            }else{
                print(error?.localizedDescription)}
        })
    }
    
    func getUserData(){
        let userID = Auth.auth().currentUser?.uid
        db.collection("Users").document(userID!).getDocument { [self] snapshot, error in
            let result = snapshot!.data()!
            let user = User(uid: userID!,
                            userName: result["userName"] as! String,
                            email: result["email"] as? String
            )
            self.profileUserName.text = user.userName
            self.profileEmail.text = user.email
        }
    }

    func presentLoginScreen (){
        self.navigationController?.popToRootViewController(animated: true)
    }
}
