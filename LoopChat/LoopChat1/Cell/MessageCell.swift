//
//  MessageCell.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 27/05/1443 AH.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var messageBckground: UIView!
    @IBOutlet weak var messageBody: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
