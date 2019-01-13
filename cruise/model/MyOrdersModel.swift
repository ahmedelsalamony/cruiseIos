//
//  MyOrdersModel.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/5/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import Foundation

struct MyOrdersModel {


    var billaddress : String?
    var billlat : String?
    var billlong : String?
    var billid : String?
    var iddeliveryuserfk : String?
    var billdate : String?
    var roomid : String?
    var clientidfk : String?
    var billstate : String?
    var deliveryusername : String?
    var deliveryuserphone : String?
    var deliveryuserphoto : String?
    var deliveryusercity : String?
    var deliveryordertime : String?
    var billcost : String?
    var billProducts : [BillProducts]?
    
    init(billaddress : String? = nil ,billlat : String? = nil,billlong : String? = nil , billid : String? = nil,iddeliveryuserfk : String? = nil,billdate : String? = nil,roomid : String? = nil,clientidfk : String? = nil,billstate : String? = nil,deliveryusername : String? = nil,deliveryuserphone : String? = nil,deliveryuserphoto : String? = nil,deliveryusercity : String? = nil,deliveryordertime : String? = nil,billcost : String? = nil,billProducts : [BillProducts]? = nil ) {
        
        self.billaddress = billaddress
        self.billlat = billlat
        self.billlong = billlong
        self.billid = billid
        self.iddeliveryuserfk = iddeliveryuserfk
        self.billdate = billdate
        self.roomid = roomid
        self.clientidfk = clientidfk
        self.billid = billid
        self.roomid = roomid
        self.clientidfk = clientidfk
        self.billstate = billstate
        self.deliveryusername = deliveryusername
        self.deliveryuserphone = deliveryuserphone
        self.deliveryuserphoto = deliveryuserphoto
        self.deliveryusercity = deliveryusercity
        self.deliveryordertime = deliveryordertime
        self.billcost = billcost
        self.billProducts = billProducts
    }

}
