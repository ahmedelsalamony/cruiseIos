//
//  ClientModel.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/13/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import Foundation

struct ClientModel {
    
    var name : String!
    var email : String!
    var password : String!
    var withImage : Int!
    var profileImage : String!
    var latitude : String!
    var longitude : String!
    var phone : String!
    var deviceToken : String!
    var user_license_photo : String?
    var user_car_photo : String?
    var user_residence_photo : String?
    var user_workhours : String?
    var myproducts : [MyProducts]?
    
    init( name : String, email : String , password : String , withImage : Int? = nil, profileImage :String  ,   latitude : String , longitude :String ,  phone : String  , deviceToken : String,
          licence : String? = nil,car_photo : String? = nil,residence : String? = nil,hoursofwork : String? = nil,myproducts : [MyProducts]? = nil) {
         self.name = name
         self.email = email
         self.password = password
         self.withImage = withImage
         self.profileImage = profileImage
         self.latitude = latitude
         self.longitude = longitude
         self.phone = phone
         self.deviceToken = deviceToken
         self.user_license_photo = licence
         self.user_car_photo = car_photo
         self.user_residence_photo = residence
         self.user_workhours = hoursofwork
         self.myproducts = myproducts
    }
}

struct MyProducts {
    var productId : String!
    
    init(productId : String) {
        self.productId = productId
    }
}
