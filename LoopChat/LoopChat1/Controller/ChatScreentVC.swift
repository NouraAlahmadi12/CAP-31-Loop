//
//  ChaScreentVC.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 26/05/1443 AH.
//

import UIKit
import Firebase
class ChatScreentVC: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    var arrmasseg = ["1" , "3" , "9"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrmasseg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "ChatCellID")!
//        cell.textLabel?.text = "Hello"
        cell.textLabel?.text = arrmasseg[indexPath.row]
        return cell
    }
    
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.delegate = self
        chatTableView.dataSource = self
    }
}
