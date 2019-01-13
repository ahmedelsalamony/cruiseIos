//
//  MyOrdersServices.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/5/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MyOrdersServices {
    
    static let instance = MyOrdersServices()
    
    func getCurrentClientOrders(userId : String,completion : @escaping completionHandler){
        var arrOfBillProducts = [BillProducts]()
        var arrOfClientOrders = [MyOrdersModel]()
        Alamofire.request(CurrentClientOrders_Url+"\(userId)", method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                if response.result.error == nil {
                    completion(true)
                    guard let data = response.data else {return}
                    if let json = try? JSON(data: data) {
                        let arrOforders = json.array
                         arrOfClientOrders.removeAll()
                        for order in arrOforders!{
                            arrOfBillProducts.removeAll()
                            for product in order["bill_product"].array! {
                                let billProducts = BillProducts(productAmount: product["product_amount"].stringValue, productCost: product["product_cost"].stringValue, productId: product["id_product"].stringValue, productTitle: product["product_title"].stringValue, productImage: product["product_image"].stringValue)
                                arrOfBillProducts.append(billProducts)
                            }
                            
                            let orderModel = MyOrdersModel(billaddress: order["bill_address"].stringValue, billlat: order["bill_google_lat"].stringValue, billlong: order["bill_google_long"].stringValue, billid: order["bill_id"].stringValue, iddeliveryuserfk: order["id_delivery_user_fk"].stringValue, billdate: order["bill_date"].stringValue, roomid: order["room_id"].stringValue, clientidfk: order["client_id_fk"].stringValue, billstate: order["bill_state"].stringValue, deliveryusername: order["delivery_user_name"].stringValue, deliveryuserphone: order["delivery_user_phone"].stringValue, deliveryuserphoto: order["delivery_user_photo"].stringValue, deliveryusercity: order["delivery_user_city"].stringValue, deliveryordertime: order["delivery_order_time"].stringValue, billcost: order["bill_cost"].stringValue, billProducts: arrOfBillProducts)
                            arrOfClientOrders.append(orderModel)
                        }
                        NotificationCenter.default.post(name: Notification.Name.ClientCurrentOrdersNotification, object: arrOfClientOrders)
                    }
                }else {
                    completion(false)
                }
        }
    }
    
    
    func getPreviousClientOrders(userId : String,completion : @escaping completionHandler ){
        var arrOfBillProducts = [BillProducts]()
        var arrOfClientOrders = [MyOrdersModel]()
        Alamofire.request(PreviousClientOrders_Url+"\(userId)", method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                if response.result.error == nil {
                    completion(true)
                    guard let data = response.data else {return}
                    if let json = try? JSON(data: data) {
                        
                        arrOfClientOrders.removeAll()
                        let arrOforders = json.array
                        for order in arrOforders!{
                               arrOfBillProducts.removeAll()
                            for product in order["bill_product"].array! {
                                let billProducts = BillProducts(productAmount: product["product_amount"].stringValue, productCost: product["product_cost"].stringValue, productId: product["id_product"].stringValue, productTitle: product["product_title"].stringValue, productImage: product["product_image"].stringValue)
                                arrOfBillProducts.append(billProducts)
                            }
                            
                            let orderModel = MyOrdersModel(billaddress: order["bill_address"].stringValue, billlat: order["bill_google_lat"].stringValue, billlong: order["bill_google_long"].stringValue, billid: order["bill_id"].stringValue, iddeliveryuserfk: order["id_delivery_user_fk"].stringValue, billdate: order["bill_date"].stringValue, roomid: order["room_id"].stringValue, clientidfk: order["client_id_fk"].stringValue, billstate: order["bill_state"].stringValue, deliveryusername: order["delivery_user_name"].stringValue, deliveryuserphone: order["delivery_user_phone"].stringValue, deliveryuserphoto: order["delivery_user_photo"].stringValue, deliveryusercity: order["delivery_user_city"].stringValue, deliveryordertime: order["delivery_order_time"].stringValue, billcost: order["bill_cost"].stringValue, billProducts: arrOfBillProducts)
                            
                            arrOfClientOrders.append(orderModel)
                        }
                        NotificationCenter.default.post(name: Notification.Name.ClientPreviousOrdersNotification, object: arrOfClientOrders)
                         print("object :: \(arrOfClientOrders)")
                    }
                }else {
                    completion(false)
                }
        }
    }
    
    func getDriverGroceryOrders(orderstype : String,userId : String,completion : @escaping completionHandler ){
        var arrOfBillProducts = [BillProducts]()
        var arrOfClientOrders = [DriverGroceryModel]()
        Alamofire.request(DriverGrocery_Url+"\(orderstype)/"+"\(userId)", method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                if response.result.error == nil {
                    completion(true)
                    guard let data = response.data else {return}
                    if let json = try? JSON(data: data) {
                        
                        arrOfClientOrders.removeAll()
                        let arrOforders = json.array
                        for order in arrOforders!{
                            arrOfBillProducts.removeAll()
                            for product in order["bill_product"].array! {
                                let billProducts = BillProducts(productAmount: product["product_amount"].stringValue, productCost: product["product_cost"].stringValue, productId: product["id_product"].stringValue, productTitle: product["product_title"].stringValue, productImage: product["product_image"].stringValue)
                                arrOfBillProducts.append(billProducts)
                            }
                            
                            let orderModel = DriverGroceryModel(billaddress: order["bill_address"].stringValue, billlat: order["bill_google_lat"].stringValue, billlong: order["bill_google_long"].stringValue, billid: order["bill_id"].stringValue, iddeliveryuserfk: order["id_delivery_user_fk"].stringValue, billdate: order["bill_date"].stringValue, roomid: order["room_id"].stringValue, clientidfk: order["client_id_fk"].stringValue, billstate: order["bill_state"].stringValue, clientusername: order["client_user_name"].stringValue, clientuserphone: order["client_user_phone"].stringValue, cleintuserphoto: order["client_user_photo"].stringValue, clientusercity: order["client_user_city"].stringValue, deliveryordertime: order["delivery_order_time"].stringValue, billcost: order["bill_cost"].stringValue, billProducts: arrOfBillProducts)
                            
                            arrOfClientOrders.append(orderModel)
                        }
                        NotificationCenter.default.post(name: Notification.Name.DriverGroceryNotification, object: arrOfClientOrders)
                    }
                }else {
                    completion(false)
                }
        }
    }

    func orderDelivered(billId : String ,params : [String:Any], completion : @escaping completionHandler){
        print("BILLLL \(billId)")
        Alamofire.request(EndBill_Url+"\(billId)", method: .post, parameters: params, encoding: URLEncoding.default, headers: URLEncodHeader).responseJSON { response in
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
