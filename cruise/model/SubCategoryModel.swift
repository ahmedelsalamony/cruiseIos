//
//  SubCategoryModel.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/23/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import Foundation

struct SubCategoryModel : Codable {
    
    var market_id : String?
    var category_id : String?
    var category_name : String?
    var category_img : String?
    var subsupermodel : [SubSuperModel]?
    
    init(market_id : String? , category_id : String?,category_name : String? ,category_img : String? , subsupermodel : [SubSuperModel]? = nil) {
        self.market_id = market_id
        self.category_id = category_id
        self.category_name = category_name
        self.category_img = category_img
        self.subsupermodel = subsupermodel
    }
    
}
