//
//  ChatsScreenVC.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 19/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
class CommunityVC: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    let db = Firestore.firestore()
    var communities = [Community]()
    
    @IBOutlet weak var newCommunityName: UITextField!
    @IBOutlet weak var CommunityTableView: UITableView!
    
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
            print(snapshot)
            if let dataArray = snapshot.value as? [String: Any]{
                if let communityName = dataArray["communitytName"] as? String{
                    let community = Community.init(communityName: self.newCommunityName.text! , communityMember: [])
                    self.communities.append(community)
                    self.CommunityTableView.reloadData()
                }
            }
        }
    }
    
    func presentLoginScreen (){
        let viewController = storyboard?.instantiateViewController(withIdentifier: "LoginScreenID") as! SignupAndLoginVC
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.showDetailViewController(viewController, sender: self)
    }
    
    
    // MARK: tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CommunityTableView.dequeueReusableCell(withIdentifier: "CommunityCellID", for: indexPath) as! CommunityTVC
        cell.communityName.text = communities[indexPath.row].communityName
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CommunityTableView.delegate = self
        CommunityTableView.dataSource = self
        observeCommunity()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let currentUser = Auth.auth().currentUser
        if (currentUser?.uid == nil ) {
            presentLoginScreen()
        }
    }
}
