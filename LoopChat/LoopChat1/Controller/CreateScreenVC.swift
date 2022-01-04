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
    
    let db = Firestore.firestore()
    var communities = [Community]()
    override func viewDidLoad() {
        super.viewDidLoad()
        observeCommunity()
    }
    @IBAction func createNewCommunityButton(_ sender: Any) {
        
        guard let nameOfCommunity = newCommunityName.text , nameOfCommunity.isEmpty == false else {
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
        
        let databaseRef = Database.database().reference()
        databaseRef.child("communities").observe(.childAdded){(snapshot) in
            if let dataArray = snapshot.value as? [String: Any]{
                if let communityName = dataArray["communitytName"] as? String{
                    let community = Community.init(communityName: self.newCommunityName.text! , communityMember: [])
                    self.communities.append(community)
                }
            }
        }
    }
}
