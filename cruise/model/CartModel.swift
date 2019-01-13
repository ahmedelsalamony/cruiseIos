//
//  CartModel.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/6/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import Foundation

struct CartModel  {
    
    var name : String!
    var amount : Int!
    var price : Float!
    var id : String!
    var img : String!
    
    
    init(name : String,amount : Int ,price : Float , id : String,img : String ) {
        self.name = name
        self.amount = amount
        self.price = price
        self.id = id
        self.img = img
    }
    
}
