//
//  ExpandableViewCell.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/19/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit
import BEMCheckBox

protocol expandableCellSelected {
    func expandableCellSelectedDelegate(state : Bool)
}

class ExpandableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var chkbox: BEMCheckBox!
    var delegate : expandableCellSelected?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func chkboxClicked(_ sender: Any) {
        print("cell is selectedkasdas ")
        if chkbox.isEnabled {
            delegate?.expandableCellSelectedDelegate(state: true)
        }else {
            delegate?.expandableCellSelectedDelegate(state: false)
        }
        
    }
}
