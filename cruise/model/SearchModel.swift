//
//  SearchModel.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/24/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import Foundation

struct SearchModel  {
    
    var product_id : String?
    var is_admin : String?
    var main_department : String?
    var market_id : String?
    var product_cost : String?
    var categories_name : String?
    var id_categories : String?
    var product_name : String?
    var product_image : String?
    var product_content : String?
    var market_name : String?
    var market_phone : String?
    var market_google_lat : String?
    var market_google_long : String?
    var market_city : String?
    var market_photo : String?
    var delivery_cost : String?
 
    init(product_id : String,is_admin:String,main_department: String,market_id : String ,product_cost : String,categories_name : String ,id_categories : String,product_name : String ,product_image : String ,product_content : String,market_name : String,market_phone :String ,market_google_lat : String ,market_google_long : String,market_city : String,market_photo : String,delivery_cost : String) {
        
        self.product_id = product_id
        self.is_admin = is_admin
        self.main_department = main_department
        self.market_id = market_id
        self.product_cost = product_cost
        self.categories_name = categories_name
        self.id_categories = id_categories
        self.product_name = product_name
        self.product_image = product_image
        self.product_content = product_content
        self.market_name = market_name
        self.market_phone = market_phone
        self.market_google_lat = market_google_lat
        self.market_google_long = market_google_long
        self.market_city = market_city
        self.delivery_cost = delivery_cost
        
    }
    
}
