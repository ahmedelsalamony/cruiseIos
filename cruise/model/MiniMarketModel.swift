//
//  MiniMarketModel.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/31/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import Foundation

struct MiniMarketModel {
    
    var market_id : String?
    var market_name : String?
    var market_phone : String?
    var market_google_lat : String?
    var market_google_long : String?
    var market_city : String?
    var market_photo : String?
    var delivery_cost : String?
    var distance : Double?
    var minimarketcategories : [MiniMarketCategories]?
    
    init(marketid : String,marketname : String,marketphone : String, marketgooglelat : String,marketgooglelong : String, marketcity : String , marketphoto : String, deliverycost : String, distance : Double , minimarketcategories : [MiniMarketCategories]  ) {
         self.market_id = marketid
         self.market_name = marketname
         self.market_phone = marketphone
         self.market_google_lat = marketgooglelat
         self.market_google_long = marketgooglelong
         self.market_city = marketcity
         self.market_photo = marketphoto
         self.delivery_cost = deliverycost
         self.distance = distance
         self.minimarketcategories = minimarketcategories
    }
    
}

struct MiniMarketCategories {
    
 
    var id_categories : String?
    var name_categories : String?
    var image_categories : String?
    var minimarketproducts : [MiniMarketProducts]?
    
    init(idcategories : String , namecategories : String , imagecategories : String , minimarketproducts : [MiniMarketProducts]) {
        self.id_categories = idcategories
        self.name_categories = namecategories
        self.image_categories = imagecategories
        self.minimarketproducts = minimarketproducts
    }
    
}

struct MiniMarketProducts {
    
    var id_product : String?
    var product_title : String?
    var product_image : String?
    var product_price : String?
    var product_content : String?
    
    
    init(idproduct : String , producttitle : String , productimage : String,productprice : String,productcontent : String ) {
        self.id_product = idproduct
        self.product_title = producttitle
        self.product_image = productimage
        self.product_price = productprice
        self.product_content = productcontent
    }
}
