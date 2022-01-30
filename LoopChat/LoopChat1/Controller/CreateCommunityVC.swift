//
//  CreateCommunityVC.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 17/06/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
let db = Firestore.firestore()

class CreateCommunityVC: UIViewController {
    
    @IBOutlet weak var addNewImage: UIImageView!
    @IBOutlet weak var addNewName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func addImage(_ sender: Any) {  
    }
    
    @IBAction func createCommunityButton(_ sender: Any) {
        guard let nameOfCommunity = addNewName.text , nameOfCommunity.isEmpty == false else {
            return
        }
        let databaseRef = Database.database().reference()
        let community = databaseRef.child("communities").childByAutoId()
        let dataArray:[String:Any] = ["CommunityName": nameOfCommunity]
        community.setValue(dataArray){error , ref in
            if error == nil{
                self.addNewName.text = ""
            }
            
        }
    }
    
}
