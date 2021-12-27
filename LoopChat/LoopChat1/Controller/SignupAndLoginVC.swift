//
//  SignupAndLoginVC.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 16/05/1443 AH.
//

import UIKit
import Firebase
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
            cell.UserName.isHidden = true
            cell.statusLabel.text = "Don't have an account ?"
            cell.actionButton.setTitle("Sign in", for: .normal)
            cell.slideButton.setTitle("Join Us..!", for: .normal)
            cell.actionButton.addTarget(self, action: #selector(loginButtonAction(_:)), for: .touchUpInside)
            cell.slideButton.addTarget(self, action: #selector(slideToLogInCell(_:)), for: .touchUpInside)
            
            /* Sign up cell */
        }else{
            cell.confirmPassword.isHidden = false
            cell.email.isHidden = false
            cell.statusLabel.text = "Already have an account ?"
            cell.actionButton.setTitle("Ready to go..", for: .normal)
            cell.slideButton.setTitle("Sign in", for: .normal)
            cell.slideButton.addTarget(self, action: #selector(slideToSignUpCell(_:)), for: .touchUpInside)
            cell.actionButton.addTarget(self, action: #selector(signupButtonAction(_:)), for: .touchUpInside)
        }
        return cell
    }
    /*  @objc func to make the slide motion */
    @objc func slideToSignUpCell(_ sender: UIButton){
        let path = IndexPath(row: 0, section: 0)
        signupAndSigninCV.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
    }
    
    @objc func slideToLogInCell(_ sender: UIButton){
        let path = IndexPath(row: 1, section: 0)
        signupAndSigninCV.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
    }
    
    /* take the actioButton and make it signup button action*/
    @objc func signupButtonAction(_ sender: UIButton){
        let path = IndexPath(row: 1, section: 0)
        signupAndSigninCV.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
        let signupUserInfo = signupAndSigninCV.cellForItem(at: path) as! UserCVCell
        guard let email = signupUserInfo.email.text , let password = signupUserInfo.password.text , let confirmPassword = signupUserInfo.confirmPassword.text else{
            return
        }
        if(email.isEmpty == true || password.isEmpty == true){
            self.showError(errorView: "can not be Empty")
        }else if(password != confirmPassword){
            self.showError(errorView: "The passwords is not match")
        }else{
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if(error == nil){
                    print("sign up")
                    let refrenceFromDatabase = Database.database().reference()
                    guard let userID = result?.user.uid , let userName = signupUserInfo.UserName.text else{
                        return
                    }
                    let oneUser = refrenceFromDatabase.child("Users").child(userID)
                    let userDataArray:[String : Any] = ["userName" : userName]
                    oneUser.setValue(userDataArray)
                }
            }
        }
    }
    
    /* take the actioButton and make it log in button action*/
    @objc func loginButtonAction(_ sender: UIButton){
        let path = IndexPath(row: 0, section: 0)
        let loginUserInfo = signupAndSigninCV.cellForItem(at: path) as! UserCVCell
        guard let email = loginUserInfo.email.text , let password = loginUserInfo.password.text else{
            return
        }
        if(password.isEmpty == true){
            self.showError(errorView: "can not be Empty")
        }else{
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if(error == nil){
                    self.presentChatScreen()
                }else{
                    self.showError(errorView: "User name or Password is wrong")
                }
            }
        }
    }
    func showError(errorView:String){
        let alert = UIAlertController.init(title: "Error", message: errorView, preferredStyle: .alert)
        present(alert, animated: true)
        let button = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(button)
    }
    
    func presentChatScreen(){
        let viewController = storyboard?.instantiateViewController(withIdentifier: "ChatID") as! ChatsScreenVC
        self.view.window?.rootViewController = viewController
        self.view.window?.makeKeyAndVisible()
    }
}
