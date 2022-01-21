//
//  ChaScreentVC.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 26/05/1443 AH.
//

import UIKit
import Firebase
class ChatScreentVC: UIViewController {
    
    var messageArr = [Message]()
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var sendMessageOutlet: UIButton!
    @IBAction func sendMessageAction(_ sender: Any) {
        
        messageTextField.endEditing(true)
        messageTextField.isEnabled = false
        sendMessageOutlet.isEnabled = false
        
        let messageDB = Database.database().reference().child("Messages")
        let messageDict = ["Sender" : Auth.auth().currentUser?.email, "MessageBody" : messageTextField.text!]
        messageDB.childByAutoId().setValue(messageDict){(error,ref) in
            if(error != nil){
                print(error)
            }else{
                debugPrint("Msg saved successfully")
                self.messageTextField.isEnabled = true
                self.sendMessageOutlet.isEnabled = true
                self.messageTextField.text = nil
            }
        }
    }
    
    func getMessages(){
        let msgDB = Database.database().reference().child("Messages")
        msgDB.observe(.childAdded) { (snapShot) in
            let value = snapShot.value as! Dictionary<String,String>
            let text = value["MessageBody"]!
            let sender = value["Sender"]!
            var msg = Message(sender: sender, messageBody: text)
            msg.messageBody = text
            msg.sender = sender
            self.messageArr.append(msg)
            debugPrint(self.messageArr.count)
            self.chatTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ChatCellID")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getMessages()
    }
}

extension ChatScreentVC: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "ChatCellID") as! MessageCell
        cell.messageBody.text = messageArr[indexPath.row].messageBody
        cell.userName.text = messageArr[indexPath.row].sender
        cell.userImage.image = UIImage(named: "profilePic")
        return cell
    }
    
}
