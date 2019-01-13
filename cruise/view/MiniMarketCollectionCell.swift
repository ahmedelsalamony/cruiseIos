//
//  MiniMarketCollectionCell.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/17/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit
import SDWebImage

class MiniMarketCollectionCell: UICollectionViewCell {

    @IBOutlet weak var cellMinimarketImg: UIImageView!
    @IBOutlet weak var cellMarketNamelbl: UILabel!
    @IBOutlet weak var cellMarketDistancelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setMiniMarketData(model : MiniMarketModel){
        
        cellMinimarketImg.sd_setImage(with: URL(string: Images_Url + model.market_photo!)) { (image, error, cache, urls) in
            if (error != nil) {
                self.cellMinimarketImg.image = UIImage(named: "bg")
            } else {
                self.cellMinimarketImg.image = image
            }
        }
        cellMarketNamelbl.text = model.market_name
        let c:String = String(format:"%.1f", model.distance!)
        
        cellMarketDistancelbl.text = c
    }
}

