//
//  GroceryNotificationBillProductsCell.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/3/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import UIKit

class GroceryNotificationBillProductsCell: UITableViewCell {

    @IBOutlet weak var ivproductphoto: UIImageView!
    @IBOutlet weak var lblproductname: UILabel!
    @IBOutlet weak var lblproductamount: UILabel!
    @IBOutlet weak var lblproductprice: UILabel!
    @IBOutlet weak var viewcontainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
    
    func setupdata(model : BillProducts){
        lblproductname.text = model.productTitle!
        lblproductamount.text = model.productAmount!
        lblproductprice.text = model.productCost! + "SAR"
        
        ivproductphoto.sd_setImage(with: URL(string: Images_Url + model.productImage!)) { (image, error, cache, urls) in
            if (error != nil) {
                self.ivproductphoto.image = UIImage(named: "bg")
            } else {
                self.ivproductphoto.image = image
            }
        }
    }
    
}
