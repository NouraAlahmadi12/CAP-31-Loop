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
    var userName1 : String = ""
    
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
            let dataArray: [String:Any] = ["SenderName" : userName1 ,"SenderID": userid , "messageBody": text]
            
            let community = databaseRef.child("communities").child(communityid)
            community.child("Messages").childByAutoId().setValue(dataArray) { error, ref in
                if(error == nil){
                    self.messageTextField.text = ""
                    print("..........saved successfully..........")
                }else{
                    print(error!.localizedDescription)
                }
            }
        }
    }
    
    func getMessage(){
        let databaseRef = Database.database().reference()
        if let communityid = self.community?.communityID {
            databaseRef.child("communities").child(communityid).child("Messages").observe(.childAdded) { snapShot in
                if let dataArray = snapShot.value as? [String:Any] {
                    if let messagBody = dataArray["messageBody"] as? String , let userName = dataArray["SenderName"] as? String , let senderID = dataArray["SenderID"] as? String{
                        let message = Message(senderName: userName, senderID: senderID , messageBody: messagBody)
                        self.messageArr.append(message)
                        self.chatTableView.reloadData()
                    }
                }
            }
        }
    }
    
    func userNameFunction(){
        let userid = Auth.auth().currentUser?.uid
        db.collection("Users").document(userid!).getDocument { [self] snapshot, error in
            let result = snapshot!.data()!
            let user = User(uid: userid!,
                            userName: result["userName"] as! String,
                            email: result["email"] as? String
                            
            )
            self.userName1 = user.userName
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = community?.communityName
        chatTableView.separatorStyle = .none
        chatTableView.allowsSelection = false
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ChatCellID")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("iam here ")
        print("...............this is the array of message...............\(self.messageArr.count)")
        userNameFunction()
        getMessage()
    }
    
}

// MARK: tableView protocols
extension ChatScreentVC: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self.messageArr[indexPath.row]
        let userid = Auth.auth().currentUser?.uid
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "ChatCellID") as! MessageCell
        cell.setMessageData(message: message)
        cell.messageBubble.layer.cornerRadius = 15
        cell.messageBody.isEditable = false
        
        if (message.senderID == userid){
            cell.bubleStyle(style: .outComing)
        }else{
            cell.bubleStyle(style: .inComing)
        }
        return cell
    }
    
}
