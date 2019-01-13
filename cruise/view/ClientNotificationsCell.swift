//
//  ClientNotificationsCell.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/2/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import UIKit

class ClientNotificationsCell: UITableViewCell {
    
    @IBOutlet weak var viewcontainer: UIView!
    @IBOutlet weak var ivDeliveryphoto: UIImageView!
    @IBOutlet weak var lblDeliveryName: UILabel!
    @IBOutlet weak var lblDeliveryDate: UILabel!
    @IBOutlet weak var lblDeliveryStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //circular style for imageview
        ivDeliveryphoto.layer.cornerRadius = ivDeliveryphoto.frame.width / 2
        ivDeliveryphoto.clipsToBounds = true
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
        lblDeliveryName.text = model.deliveryUserName
        lblDeliveryDate.text = model.deliveryOrderTime
        if (model.deliveryOrdersReplay == "1"){
            lblDeliveryStatus.text = "تم قبول الطلب"
        }else if (model.deliveryOrdersReplay  == "2"){
            lblDeliveryStatus.text = "تم رفض طلب التوصيل"
        }else if (model.deliveryOrdersReplay  == "3"){
            lblDeliveryStatus.text = "تم رفض طلب التوصيل ولا يوجد سائقيين متاحيين"
        }
    
        ivDeliveryphoto.sd_setImage(with: URL(string: Images_Url + model.deliveryUserPhoto!)) { (image, error, cache, urls) in
            if (error != nil) {
                self.ivDeliveryphoto.image = UIImage(named: "bg")
            } else {
                self.ivDeliveryphoto.image = image
            }
        }
    }
}
