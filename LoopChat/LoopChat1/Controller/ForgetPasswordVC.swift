//
//  ForgetPasswordVC.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 28/06/1443 AH.
//

import UIKit
import FirebaseAuth
class ForgetPasswordVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var userEmail: UITextField!
    @IBAction func sendRestPasswordLink(_ sender: Any) {
        if (userEmail.text?.isEmpty == false) {
            Auth.auth().sendPasswordReset(withEmail: userEmail.text!) { error in
                if error == nil{
                    print("send")
                    self.userEmail.text = ""
                    self.showMessage(errorView: "check your Email")
                }else{
                    print(error?.localizedDescription)
                    self.showMessage(errorView: "email does not exist")
                }
            }
        }else{
            showMessage(errorView: "Connot be Emapty")
        }
        
    }
    func showMessage(errorView:String){
        let alert = UIAlertController.init(title: "Message", message: errorView, preferredStyle: .alert)
        present(alert, animated: true)
        let button = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(button)
    }

}
