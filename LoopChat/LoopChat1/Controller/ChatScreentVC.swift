//
//  ChaScreentVC.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 26/05/1443 AH.
//

import UIKit
import Firebase
class ChatScreentVC: UIViewController {
    
    var messageArr : [Message] = []
    var community : Community?
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendMessageOutlet: UIButton!
    @IBAction func sendMessageAction(_ sender: Any) {
        guard let chatTxt = self.messageTextField.text , chatTxt.isEmpty == false else { return }
        sendMessage(text: chatTxt)
    }
    
    
    func sendMessage(text:String){
        guard let userid = Auth.auth().currentUser?.uid else{return}
        let databaseRef  = Database.database().reference()
        if let communityid = self.community?.communityID {
            print(communityid)
            let dataArray: [String:Any] = ["SenderID": userid , "messageBody": text]
            
            let community = databaseRef.child("communities").child(communityid)
            community.child("Messages").childByAutoId().setValue(dataArray) { error, ref in
                if(error != nil){
                    self.messageTextField.text = ""
                }else{
                    print("..........saved successfully..........")
                }
            }
        }
    }
    
    func getMessage(){
        let databaseRef = Database.database().reference()
        if let communityid = self.community?.communityID {
            databaseRef.child("communities").child(communityid).child("Messages").observe(.childAdded) { snapShot in
                if let dataArray = snapShot.value as? [String:Any] {
                    if let messagBody = dataArray["messageBody"] as? String{
                        let message = Message(senderID: snapShot.key , messageBody: messagBody)
                        self.messageArr.append(message)
                        self.chatTableView.reloadData()
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ChatCellID")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("iam here ")
        print("...............this is the array of message...............\(self.messageArr.count)")
        getMessage()
    }
    
}

// MARK: tableView protocols
extension ChatScreentVC: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "ChatCellID") as! MessageCell
        cell.messageBody.text = messageArr[indexPath.row].messageBody
        cell.userName.text = messageArr[indexPath.row].senderID
        cell.layer.cornerRadius = 10
        return cell
    }
    
}
