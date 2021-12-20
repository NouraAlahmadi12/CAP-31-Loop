//
//  SignupAndLoginVC.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 16/05/1443 AH.
//

import UIKit

class SignupAndLoginVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource{


    @IBOutlet weak var signupAndSigninCV: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupAndSigninCV.delegate = self
        signupAndSigninCV.dataSource = self
        signupAndSigninCV.isScrollEnabled = false
    }
    
    // MARK: CollectionView function
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.signupAndSigninCV.dequeueReusableCell(withReuseIdentifier: "HomeCellID", for: indexPath) as! UserCVCell
        /* Log in cell */
        if(indexPath.row == 0){
            cell.confirmPassword.isHidden = true
            cell.email.isHidden = true
            cell.statusLabel.text = "Don't have an account ?"
            cell.actionButtonTEXT.setTitle("Sign in", for: .normal)
            cell.slideButtonTEXT.setTitle("Join Us..!", for: .normal)
            cell.slideButtonTEXT.addTarget(self, action: #selector(slideToLogInCell(_:)), for: .touchUpInside)
        /* Sign up cell */
        }else{
            cell.confirmPassword.isHidden = false
            cell.email.isHidden = false
            cell.statusLabel.text = "Already have an account ?"
            cell.actionButtonTEXT.setTitle("Ready to go..", for: .normal)
            cell.slideButtonTEXT.setTitle("Sign in", for: .normal)
            cell.slideButtonTEXT.addTarget(self, action: #selector(slideToSignUpCell(_:)), for: .touchUpInside)
        }
        return cell
    }
    /*  @objc func to make the slide motion */
    @objc func slideToSignUpCell(_ sender: UIButton){
        let path = IndexPath(row: 0, section: 0)
        self.signupAndSigninCV.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
    }
    
    
    @objc func slideToLogInCell(_ sender: UIButton){
        let path = IndexPath(row: 1, section: 0)
        self.signupAndSigninCV.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
    }

}

