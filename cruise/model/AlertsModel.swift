//
//  AlertsModel.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/2/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import Foundation

struct AlertsModel {
    var deliveryOrderId : String?
    var marketType : String?
    var deliveryOrdersReplay : String?
    var isRead : String?
    var deliveryUserName : String?
    var deliveryUserPhone : String?
    var deliveryUserPhoto : String?
    var deliveryOrderTime : String?
    var billLat : String?
    var billLong : String?
    var billCost : String?
    var billProducts : [BillProducts]?
    var clientName : String?
    var clientPhoto : String?
    var clientPhone : String?
    var clientAddress : String?
    var billAddress : String?
    var billnumfk : String?
    var idclientfk : String?
    
    
    
    init(deliveryOrderId : String? = nil,marketType : String? = nil,deliveryOrdersReplay : String? = nil,isRead : String? = nil,deliveryUserName : String? = nil,deliveryUserPhone : String? = nil,deliveryUserPhoto : String? = nil,
         deliveryOrderTime : String? = nil,billLat : String? = nil,billLong : String? = nil,billCost : String? = nil,
         billProducts : [BillProducts]? = nil,clientPhoto : String? = nil,
         clientPhone : String? = nil,clientAddress : String? = nil,billAddress : String? = nil,clientName : String? = nil,billnumfk : String? = nil,idcleintfk : String? = nil) {
        self.deliveryOrderId = deliveryOrderId
        self.marketType = marketType
        self.deliveryOrdersReplay = deliveryOrdersReplay
        self.isRead = isRead
        self.deliveryUserName = deliveryUserName
        self.deliveryUserPhone = deliveryUserPhone
        self.deliveryUserPhoto = deliveryUserPhoto
        self.deliveryOrderTime = deliveryOrderTime
        self.billLong = billLong
        self.billLat = billLat
        self.billCost = billCost
        self.billProducts = billProducts
        self.clientName = clientName
        self.clientPhoto = clientPhoto
        self.clientPhone = clientPhone
        self.clientAddress = clientAddress
        self.billAddress = billAddress
        self.billnumfk = billnumfk
        self.idclientfk = idcleintfk
    }
}

struct BillProducts {
    var productAmount : String?
    var productCost : String?
    var productId : String?
    var productTitle : String?
    var productImage : String?
    
    init(productAmount : String? = nil,productCost : String? = nil,productId : String? = nil,productTitle : String? = nil,productImage : String? = nil) {
        self.productAmount = productAmount
        self.productCost = productCost
        self.productId = productId
        self.productTitle = productTitle
        self.productImage = productImage
    }
}
