//
//  SubSuperModel.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/19/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import Foundation

struct SubSuperModel : Codable{
    
    var id_product : String?
    var product_title : String?
    var product_image : String?
    var product_price : String?
    
    init(id_product : String,product_title : String,product_image : String,product_price : String) {
        self.id_product = id_product
        self.product_title = product_title
        self.product_image = product_image
        self.product_price = product_price
    }
}
