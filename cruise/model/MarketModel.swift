//
//  MarketModel.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/16/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//
import Foundation

struct MarketModel : Codable {
    
    var market_id : String?
    var market_name : String?
    var market_phone : String?
    var market_google_lat : String?
    var market_google_long : String?
    var market_city : String?
    var market_photo : String?
    var delivery_cost : String?
    var id_categories : String?
    var name_categories : String?
    var image_categories : String?
    var distance : Double?
    var superdetails : [SubSuperModel]?
    var subcategorymodel : [SubCategoryModel]?
    var superOrMini : String?
 
   
 
    
    init(market_id : String , market_name: String,market_phone:String,market_google_lat : String,market_google_long : String,market_city : String,market_photo : String,delivery_cost : String,id_categories : String? = nil ,name_categories : String? = nil,
         image_categories : String? = nil ,distance : Double? = nil , superdetails : [SubSuperModel]? = nil , subcategorymodel : [SubCategoryModel]? = nil,superOrMini : String? = nil ) {

        self.market_id = market_id
        self.market_name = market_name
        self.market_phone = market_phone
        self.market_google_lat = market_google_lat
        self.market_google_long = market_google_long
        self.market_city = market_city
        self.market_photo = market_photo
        self.delivery_cost = delivery_cost
        self.id_categories = id_categories
        self.name_categories = name_categories
        self.image_categories = image_categories
        self.distance = distance
        self.superdetails = superdetails
        self.subcategorymodel = subcategorymodel
        self.superOrMini = superOrMini
    }
 
    
}
