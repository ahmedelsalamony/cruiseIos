//
//  ChatCellToImg.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/12/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import UIKit

class ChatCellToImg: UITableViewCell {

    @IBOutlet weak var ivprofile: UIImageView!
    @IBOutlet weak var ivmsg: UIImageView!
    @IBOutlet weak var lbltime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
