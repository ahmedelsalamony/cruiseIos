//
//  MiniDetailsCollectionCell.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/22/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit
import SDWebImage

class MiniDetailsCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imgcategory: CurvedImageStyle!
    @IBOutlet weak var lblcategory: UILabel!
    
    //vars
    var arrOfMinimarketCategories = [MiniMarketCategories]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupDataToCell(model : MiniMarketCategories){
        
        imgcategory.sd_setImage(with: URL(string: Images_Url + model.image_categories!)) { (image, error, cache, urls) in
            if (error != nil) {
                self.imgcategory.image = UIImage(named: "bg")
            } else {
                self.imgcategory.image = image
            }
        }
        lblcategory.text = model.name_categories!
    }

}
