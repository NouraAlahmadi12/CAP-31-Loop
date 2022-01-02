//
//  CreateScreenVC.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 29/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestore

class CreateScreenVC: UIViewController {

    @IBOutlet weak var newCommunityImage: UIImageView!
    @IBOutlet weak var newCommunityName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeCommunity()
    }
    @IBAction func createNewCommunityButton(_ sender: Any) {
        
        guard let nameOfCommunity = newCommunityName.text , nameOfCommunity.isEmpty == false else{
            return
        }
        
        let databaseRefrence = Database.database().reference()
        let communities = databaseRefrence.child("communities").childByAutoId()
        
        let dataArray: [String : Any] = ["Community Name": nameOfCommunity]
        communities.setValue(dataArray) { error, ref in
            self.newCommunityName.text = ""
        }
    }
    
    func observeCommunity(){
        
        let databaseRefrence = Database.database().reference()
        databaseRefrence.child("communities").observe(.childAdded) { snapshot in
            print("the room name is : \(snapshot)")
        }
        
    }
}
