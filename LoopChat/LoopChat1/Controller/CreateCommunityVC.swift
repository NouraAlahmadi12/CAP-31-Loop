//
//  CreateCommunityVC.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 17/06/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class CreateCommunityVC: UIViewController {

    @IBOutlet weak var addNewImage: UIImageView!
    @IBOutlet weak var addNewName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func createCommunityButton(_ sender: Any) {
        guard let nameOfCommunity = addNewName.text , nameOfCommunity.isEmpty == false else {
            return
        }
        let databaseRefrence = Database.database().reference()
        let communities = databaseRefrence.child("communities").childByAutoId()
        let dataArray: [String : Any] = ["Community Name": nameOfCommunity]
        communities.setValue(dataArray) { error, ref in
            self.addNewName.text = ""
        }
    }
    
}
