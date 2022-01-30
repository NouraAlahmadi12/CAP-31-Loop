//
//  MessageCell.swift
//  LoopChat1
//
//  Created by Noura Alahmadi on 27/05/1443 AH.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var messageBody: UITextView!
    @IBOutlet weak var messageStack: UIStackView!
    @IBOutlet weak var messageBubble: UIView!
    
    enum messageBubleStyle{
        case inComing
        case outComing
    }
    
    func setMessageData(message:Message){
        userName.text = message.senderName
        messageBody.text = message.messageBody
    }
    
    func bubleStyle(style: messageBubleStyle){
        if(style == .inComing){
            messageStack.alignment = .leading
            messageBubble.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            messageBody.textColor = .white
            //            UIColor(red: 63, green: 100, blue: 81, alpha: 0)
            
        }else if (style == .outComing){
            messageStack.alignment = .trailing
            messageBubble.backgroundColor = #colorLiteral(red: 0.197131604, green: 0.3969036937, blue: 0.3120974302, alpha: 1)
            messageBody.textColor = .white
        }
        
    }

}
