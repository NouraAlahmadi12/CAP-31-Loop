//
//  ChatsScreenVC.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 19/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
class CommunityVC: UIViewController ,UICollectionViewDelegate , UICollectionViewDataSource{
    
    @IBOutlet weak var roomOfCommunityCV: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = roomOfCommunityCV.dequeueReusableCell(withReuseIdentifier: "CommunityCellID", for: indexPath) as! CommunityCVCell
        return cell
    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = (storyboard?.instantiateViewController(withIdentifier: "ChatScreenID")) as! ChatScreentVC
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func presentLoginScreen (){
        let viewController = storyboard?.instantiateViewController(withIdentifier: "LoginScreenID") as! SignupAndLoginVC
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.showDetailViewController(viewController, sender: self)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let currentUser = Auth.auth().currentUser
        if (currentUser?.uid == nil ) {
            presentLoginScreen()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomOfCommunityCV.delegate = self
        roomOfCommunityCV.dataSource = self
        
    }
}
