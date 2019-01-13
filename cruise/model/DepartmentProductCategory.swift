//
//  DepartmentProductCategory.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/14/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import Foundation

struct DepartmentProductCategory {
    
    var id_categories : String!
    var name_categories : String!
    var image_categories : String!
    var expanded : Bool!
    var sub_product : [SubProductModel]!
    
    init(id_categories : String,name_categories : String,image_categories : String!,expanded : Bool
        ,sub_product :[SubProductModel] ) {
        self.id_categories = id_categories
        self.name_categories = name_categories
        self.image_categories = image_categories
        self.sub_product = sub_product
        self.expanded = expanded
    }
}

struct SubProductModel {
    var id_product : String!
    var product_title : String!
    var product_image : String!
    var product_price : String!
//    var product_code : String!
//    var product_content : String!
//    var product_type : String!
//    var product_date : String!
//    var google_lat : String!
//    var google_long : String!
//    var view_count : String!
//    var publisher : String!
//    var approved : String!
    
    init(id : String,title : String ,img : String , price : String) {
        self.id_product = id
        self.product_title = title
        self.product_image = img
        self.product_price = price
//        self.product_code = code
//        self.product_content = content
//        self.product_type = type
//        self.product_date = date
//        self.google_lat = lat
//        self.google_long = long
//        self.view_count = count
//        self.publisher = publisher
//        self.approved = approved
    }
}
