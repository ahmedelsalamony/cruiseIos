//
//  PurchasesCell.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/5/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import UIKit

class PurchasesCell: UITableViewCell {

    
    @IBOutlet weak var viewcontainer: UIView!
    @IBOutlet weak var ivphoto: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lbladdress: UILabel!
    @IBOutlet weak var lblmore: UILabel!
    @IBOutlet weak var btndeliverd: UIButtonX!
    
    //vars
    var orders : MyOrdersModel!
    var drivergroceryorders : DriverGroceryModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
         let userOrderState = UserDefaults.standard.value(forKey: "_userOrderState") as? Int
        if (userOrderState == 0){
            btndeliverd.isHidden = false
        }else {
            btndeliverd.isHidden = true
        }
        // Initialization code
        ivphoto.layer.cornerRadius = ivphoto.frame.width / 2
        ivphoto.clipsToBounds = true
        //card style for cell
        viewcontainer.layer.cornerRadius = 3
        viewcontainer.layer.masksToBounds = false
        viewcontainer.layer.shadowColor = UIColor.lightGray.cgColor
        viewcontainer.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        viewcontainer.layer.shadowOpacity = 0.8
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func finishOrder(_ sender: Any) {
        let userType = UserDefaults.standard.value(forKey: "userType") as? String
        if (userType == "1"){
        let params : [String:Any] = ["user_type":UserDefaults.standard.value(forKey: "userType"),"user_id":UserDefaults.standard.value(forKey: "userId"),"id_delivery_user_fk":orders.iddeliveryuserfk,"room_id":orders.roomid]
        MyOrdersServices.instance.orderDelivered(billId: orders.billid!, params: params) { (success) in
        }
        } else {
            let params : [String:Any] = ["user_type":UserDefaults.standard.value(forKey: "userType"),"user_id":UserDefaults.standard.value(forKey: "userId"),"id_delivery_user_fk":drivergroceryorders.iddeliveryuserfk,"room_id":drivergroceryorders.roomid]
            MyOrdersServices.instance.orderDelivered(billId: drivergroceryorders.billid!, params: params) { (success) in
            }
        }
    }
    
    func setupData(model : MyOrdersModel){
        orders = model
        lblname.text = model.deliveryusername!
        lbldate.text = model.deliveryordertime!
        lbladdress.text = model.billaddress!
        
        print("shdsjha #### \(model.deliveryuserphoto!)")
        ivphoto.sd_setImage(with: URL(string: Images_Url + model.deliveryuserphoto!)) { (image, error, cache, urls) in
            if (error != nil) {
                self.ivphoto.image = UIImage(named: "bg")
            } else {
                self.ivphoto.image = image
            }
        }
    }
    
    func setupDataForDG(model : DriverGroceryModel){
        drivergroceryorders = model
        lblname.text = model.clientusername!
        lbldate.text = model.deliveryordertime
        lbladdress.text = model.billaddress!
        ivphoto.sd_setImage(with: URL(string: Images_Url + model.cleintuserphoto!)) { (image, error, cache, urls) in
            if (error != nil) {
                self.ivphoto.image = UIImage(named: "bg")
            } else {
                self.ivphoto.image = image
            }
        }
    }
    
}
