//
//  SuperMarketCollectionCell.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/17/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit

class SuperMarketCollectionCell: UICollectionViewCell {

    
    @IBOutlet weak var categoryimg: UIImageView!
    @IBOutlet weak var categorylbl: UILabel!
    
    func setCategoryData(model : MarketModel){
        print("image   \(Images_Url + model.image_categories!)")
        
        categoryimg.sd_setImage(with: URL(string: Images_Url + model.image_categories!)) { (image, error, cache, urls) in
            if (error != nil) {
                self.categoryimg.image = UIImage(named: "bg")
            } else {
                self.categoryimg.image = image
            }
        }
        categorylbl.text = model.name_categories
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    
}
