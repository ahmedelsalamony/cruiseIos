//
//  ChatTableViewCell.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/12/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    let messageLabel = UILabel()
    let timelbl = UILabel()
    let profileiv = UIImageView()
    let bubbleBackgroundView = UIView()
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!

    let myId = UserDefaults.standard.string(forKey: "userId")
    
    var chatmodel : ChattingRoomModel! {
        didSet {
            
            if chatmodel.from_id == myId {
                bubbleBackgroundView.backgroundColor = .blue
                messageLabel.textColor = .white
            }else{
                bubbleBackgroundView.backgroundColor = .gray
                messageLabel.textColor = .black
            }
                messageLabel.text = chatmodel.message
                timelbl.text = chatmodel.message_time
                timelbl.textColor = .gray
                timelbl.font = timelbl.font.withSize(10)
            
                if chatmodel.from_id != myId {
                    leadingConstraint.isActive = true
                    trailingConstraint.isActive = false
                } else {
                    leadingConstraint.isActive = false
                    trailingConstraint.isActive = true
                }
            }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        bubbleBackgroundView.backgroundColor = .yellow
        bubbleBackgroundView.layer.cornerRadius = 12
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubbleBackgroundView)
        addSubview(timelbl)
        addSubview(messageLabel)
        
        messageLabel.text = "We want to provide a longer string that is actually going to wrap onto the next line and maybe even a third line."
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        timelbl.text = "12:00 am"
        timelbl.translatesAutoresizingMaskIntoConstraints = false
        
        
        // lets set up some constraints
        let constraints = [
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
            bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16),
            
            timelbl.topAnchor.constraint(equalTo: bubbleBackgroundView.bottomAnchor, constant: 2),
            timelbl.leadingAnchor.constraint(equalTo: bubbleBackgroundView.leadingAnchor, constant: 2),
            timelbl.heightAnchor.constraint(equalToConstant: 22),
            timelbl.widthAnchor.constraint(equalToConstant: 120)
            ]
        NSLayoutConstraint.activate(constraints)
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22)
        leadingConstraint.isActive = false
        
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22)
        trailingConstraint.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
