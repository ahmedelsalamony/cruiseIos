//
//  GroceryNotificationsCell.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/3/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import UIKit

class GroceryNotificationsCell: UITableViewCell {

    @IBOutlet weak var viewcontainer: UIView!
    @IBOutlet weak var ivdeliveryphoto: UIImageView!
    @IBOutlet weak var lbldeliveryname: UILabel!
    @IBOutlet weak var lbladdress: UILabel!
    @IBOutlet weak var btnaccept: UIButtonX!
    @IBOutlet weak var btnrefuse: UIButtonX!
    @IBOutlet weak var lbldate: UILabel!
    
    var _model : AlertsModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //circular style for imageview
        ivdeliveryphoto.layer.cornerRadius = ivdeliveryphoto.frame.width / 2
        ivdeliveryphoto.clipsToBounds = true
        //card style for cell
        viewcontainer.layer.cornerRadius = 3
        viewcontainer.layer.masksToBounds = false
        viewcontainer.layer.shadowColor = UIColor.lightGray.cgColor
        viewcontainer.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        viewcontainer.layer.shadowOpacity = 0.8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(model : AlertsModel){
        print("clientname :: \(model.clientName)")
        lbldeliveryname.text = model.clientName
        lbladdress.text = model.billAddress
        lbldate.text  = model.deliveryOrderTime
        
        ivdeliveryphoto.sd_setImage(with: URL(string: Images_Url + model.clientPhoto!)) { (image, error, cache, urls) in
            if (error != nil) {
                self.ivdeliveryphoto.image = UIImage(named: "bg")
            } else {
                self.ivdeliveryphoto.image = image
            }
        }
    }
    
    @IBAction func btnAcceptClicked(_ sender: Any) {
        NotificationServices.instance.getGroceryReply(action: "1", billnumfk: _model.billnumfk!, idclientfk: _model.idclientfk!) { (success) in
            if success {
            }
        }
    }
    
    @IBAction func btnrefuse(_ sender: Any) {
        NotificationServices.instance.getGroceryReply(action: "2", billnumfk: _model.billnumfk!, idclientfk: _model.idclientfk!) { (success) in
            if success {
            }
        }
    }
    
    
    @IBAction func btnMoreClicked(_ sender: Any) {
    }
}
