//
//  NotificationServices.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/2/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class NotificationServices {
    
    static let instance = NotificationServices()
    
    func getClientAlerts(userId : String , completion : @escaping completionHandler){
        var arrOfBillProducts = [BillProducts]()
        var arrOfClientAlerts = [AlertsModel]()
        Alamofire.request(ClientAlerta_Url+"\(userId)", method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                if response.result.error == nil {
                    completion(true)
                    guard let data = response.data else {return}
                    if let json = try? JSON(data: data) {
                    let arrOfAlerts = json.array
                        for alert in arrOfAlerts!{
                            
                            for product in alert["bill_product"].array! {
                              let billProducts = BillProducts(productAmount: product["product_amount"].stringValue, productCost: product["product_cost"].stringValue, productId: product["id_product"].stringValue, productTitle: product["product_title"].stringValue, productImage: product["product_image"].stringValue)
                               arrOfBillProducts.append(billProducts)
                            }
                            
                            let alertmodel = AlertsModel(deliveryOrderId: alert["id_delivery_order"].stringValue,marketType: alert["market_type"].stringValue,deliveryOrdersReplay: alert["delivery_orders_replay"].stringValue, isRead: alert["is_read"].stringValue, deliveryUserName: alert["delivery_user_name"].stringValue, deliveryUserPhone: alert["delivery_user_phone"].stringValue, deliveryUserPhoto: alert["delivery_user_photo"].stringValue, deliveryOrderTime: alert["delivery_order_time"].stringValue, billLat: alert["bill_google_lat"].stringValue, billLong: alert["bill_google_long"].stringValue, billCost: alert["bill_cost"].stringValue, billProducts: arrOfBillProducts,billAddress: alert["bill_address"].stringValue,clientName : alert["client_name"].stringValue)
                         
                            arrOfClientAlerts.append(alertmodel)
                        }
                          NotificationCenter.default.post(name: Notification.Name.ClientAlertsNotification, object: arrOfClientAlerts)
                    }
                }else {
                 completion(false)
                }
        }
    }
    
    func getGroceryAlerts(userId : String , completion : @escaping completionHandler){
        var arrOfBillProducts = [BillProducts]()
        var arrOfClientAlerts = [AlertsModel]()
        Alamofire.request(GroceryAlert_Url+"\(userId)", method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                if response.result.error == nil {
                    completion(true)
                    guard let data = response.data else {return}
                    if let json = try? JSON(data: data) {
                        let arrOfAlerts = json.array
                        for alert in arrOfAlerts!{
                            
                            for product in alert["bill_product"].array! {
                                let billProducts = BillProducts(productAmount: product["product_amount"].stringValue, productCost: product["product_cost"].stringValue, productId: product["id_product"].stringValue, productTitle: product["product_title"].stringValue, productImage: product["product_image"].stringValue)
                                arrOfBillProducts.append(billProducts)
                            }
                            
                            let alertmodel = AlertsModel(deliveryOrderId: alert["id_delivery_order"].stringValue, marketType: alert["market_type"].stringValue, deliveryOrdersReplay: alert["delivery_orders_replay"].stringValue, isRead: alert["is_read"].stringValue, deliveryUserName: alert["delivery_user_name"].stringValue, deliveryUserPhone: alert["delivery_user_phone"].stringValue, deliveryUserPhoto: alert["delivery_user_photo"].stringValue, deliveryOrderTime: alert["delivery_order_time"].stringValue, billLat: alert["bill_google_lat"].stringValue, billLong: alert["bill_google_long"].stringValue, billCost: alert["bill_cost"].stringValue, billProducts: arrOfBillProducts,
                                                         clientPhoto: alert["client_photo"].stringValue,clientPhone: alert["client_phone"].stringValue
                                ,billAddress: alert["bill_address"].stringValue,clientName : alert["client_name"].stringValue,billnumfk : alert["billnumfk"].stringValue,idcleintfk : alert["id_client_fk"].stringValue)
                            
                            
                            arrOfClientAlerts.append(alertmodel)
                        }
                        NotificationCenter.default.post(name: Notification.Name.GroceryAlertNotification, object: arrOfClientAlerts)
                    }
                }else {
                    completion(false)
                }
        }
    }
    
    func getDriverAlerts(userId : String , completion : @escaping completionHandler){
        var arrOfBillProducts = [BillProducts]()
        var arrOfClientAlerts = [AlertsModel]()
        Alamofire.request(DriverAlert_Url+"\(userId)", method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                if response.result.error == nil {
                    completion(true)
                    guard let data = response.data else {return}
                    if let json = try? JSON(data: data) {
                        let arrOfAlerts = json.array
                        for alert in arrOfAlerts!{
                            
                            for product in alert["bill_product"].array! {
                                let billProducts = BillProducts(productAmount: product["product_amount"].stringValue, productCost: product["product_cost"].stringValue, productId: product["id_product"].stringValue, productTitle: product["product_title"].stringValue, productImage: product["product_image"].stringValue)
                                arrOfBillProducts.append(billProducts)
                            }
                            
                            let alertmodel = AlertsModel(deliveryOrderId: alert["id_delivery_order"].stringValue, marketType: alert["market_type"].stringValue, deliveryOrdersReplay: alert["delivery_orders_replay"].stringValue, isRead: alert["is_read"].stringValue, deliveryUserName: alert["delivery_user_name"].stringValue, deliveryUserPhone: alert["delivery_user_phone"].stringValue, deliveryUserPhoto: alert["delivery_user_photo"].stringValue, deliveryOrderTime: alert["delivery_order_time"].stringValue, billLat: alert["bill_google_lat"].stringValue, billLong: alert["bill_google_long"].stringValue, billCost: alert["bill_cost"].stringValue, billProducts: arrOfBillProducts,
                                                         clientPhoto: alert["client_photo"].stringValue,clientPhone: alert["client_phone"].stringValue
                                ,billAddress: alert["bill_address"].stringValue,clientName : alert["client_name"].stringValue,billnumfk : alert["billnumfk"].stringValue,idcleintfk : alert["id_client_fk"].stringValue)
                            
                            
                            arrOfClientAlerts.append(alertmodel)
                        }
                        NotificationCenter.default.post(name: Notification.Name.DriverAlertNotification, object: arrOfClientAlerts)
                    }
                }else {
                    completion(false)
                }
        }
    }
    
    
    
    
    
    func getGroceryReply(action : String , billnumfk : String , idclientfk : String ,completion : @escaping completionHandler){
        let params : [String:Any] = ["action":action,"bill_num_fk":billnumfk,"Id_client_fk":idclientfk]
        Alamofire.request(GroceryReply_Url, method: .post, parameters: params, encoding: URLEncoding.default, headers: URLEncodHeader).responseJSON { response in
            if response.result.error == nil {
                guard let data = response.data else {return}
                if let json = try? JSON(data: data) {
                    if (json["success_action"].stringValue == "1"){
                          completion(true)
                    }
                }
            }else {
                completion(false)
            }
        }
    }
    
    func getClientReply(action : String , billnumfk : String , iddeliveryuserfk : String ,market_type : String,completion : @escaping completionHandler){
        let params : [String:Any] = ["action":action,"bill_num_fk":billnumfk,"id_delivery_user_fk":iddeliveryuserfk,market_type:"market_type"]
        Alamofire.request(ClientReply_Url, method: .post, parameters: params, encoding: URLEncoding.default, headers: URLEncodHeader).responseJSON { response in
            if response.result.error == nil {
                guard let data = response.data else {return}
                if let json = try? JSON(data: data) {
                    if (json["success_action"].stringValue == "1"){
                        completion(true)
                    }
                    print("success action :: \(json["success_action"].stringValue)")
                }
            }else {
                completion(false)
            }
        }
    }
    
   

}
