//
//  ChatsScreenVC.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 19/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
class CommunityVC: UIViewController{
    
    let db = Firestore.firestore()
    let databaseRef = Database.database().reference()
    var arrayOfCommunities = [Community]()
    
    @IBOutlet weak var communityCV: UICollectionView!
    
    func observeCommunity(){
        let databaseRef = Database.database().reference()
        databaseRef.child("communities").observe(.childAdded) { snapShot in
            if let dataArray = snapShot.value as? [String: Any]{
                if let communityName = dataArray["CommunityName"] as? String{
                    let community = Community(communityName: communityName, communityID: snapShot.key)
                    print("communityID is : \(community.communityID)")
                    self.arrayOfCommunities.append(community)
                    self.communityCV.reloadData()
                }
            }
        }
    }
    
    
    @IBAction func deleteCommunity(_ sender: Any) {
        databaseRef.child("communities").removeValue()
        arrayOfCommunities.removeAll()
        communityCV.reloadData()
    }
    
    
    func presentLoginScreen (){
        let viewController = storyboard?.instantiateViewController(withIdentifier: "LoginScreenID") as! SignupAndLoginVC
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.showDetailViewController(viewController, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        communityCV.delegate = self
        communityCV.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("iam here ")
        print("...............this is the array of community...............\(self.arrayOfCommunities.count)")
        let currentUser = Auth.auth().currentUser
        if (currentUser?.uid == nil ) {
            presentLoginScreen()
        }
        self.arrayOfCommunities.removeAll()
        observeCommunity()
        
    }
}


// MARK: collectionView

extension CommunityVC: UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfCommunities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = communityCV.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let item = arrayOfCommunities[indexPath.row]
        cell.communityNameView.text = item.communityName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = (storyboard?.instantiateViewController(withIdentifier: "ChatScreenID")) as! ChatScreentVC
        vc.community = self.arrayOfCommunities[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
