//
//  HomeServices.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/16/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON

class HomeServices {
    
    static let instance = HomeServices()
    
    func getSuperMarketCategories(completion : @escaping completionHandler){
        var arrOfSuperCategories = [MarketModel]()
        var arrOfSubSuperCategories = [SubSuperModel]()
        Alamofire.request(DisplaySuperMarket_Url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                if let json = try? JSON(data: data){
                    let arrjson = json.array
                    for item in arrjson! {
                        let m_market_id = item["product_id_fk"].stringValue
                        let m_name = item["market_name"].stringValue
                        let m_phone = item["market_phone"].stringValue
                        let m_google_lat = item["market_google_lat"].stringValue
                        let m_google_long = item["market_google_long"].stringValue
                        let m_city = item["market_city"].stringValue
                        let m_photo = item["market_photo"].stringValue
                        let m_delivery_cost = item["delivery_cost"].stringValue
                        let m_id_categories = item["id_categories"].stringValue
                        let m_name_categories = item["name_categories"].stringValue
                        let m_img_categories = item["image_categories"].stringValue
                        let m_subProduct = item["sub_product"].array
                        //
                        arrOfSubSuperCategories.removeAll()
                        for subitem in m_subProduct! {
                            let m_sub_idproduct = subitem["id_product"].stringValue
                            let m_sub_producttitle = subitem["product_title"].stringValue
                            let m_sub_productimage = subitem["product_image"].stringValue
                            let m_sub_productprice = subitem["product_price"].stringValue
                            arrOfSubSuperCategories.append(SubSuperModel(id_product: m_sub_idproduct, product_title: m_sub_producttitle, product_image: m_sub_productimage, product_price: m_sub_productprice))
                        }
                        arrOfSuperCategories.append(MarketModel(market_id : m_market_id,market_name: m_name, market_phone: m_phone, market_google_lat: m_google_lat, market_google_long: m_google_long, market_city: m_city, market_photo: m_photo, delivery_cost: m_delivery_cost, id_categories: m_id_categories, name_categories: m_name_categories, image_categories: m_img_categories , superdetails : arrOfSubSuperCategories,superOrMini : "Super"))
                    }
                    NotificationCenter.default.post(name: Notification.Name.superCategoriesNotification, object: arrOfSuperCategories)
                    NotificationCenter.default.post(name: Notification.Name.subsuperCategoriesNotification, object: arrOfSubSuperCategories)
                   completion(true)
                }
            } else {
                completion(false)
            }
            print("reponse of super :: \(response)")
        }
    }
    
  
    
    func getMiniMarketCategories(lat : String,long : String ,completion : @escaping completionHandler){
        
        let params : [String:Any] = ["my_google_lat":lat,"my_google_long":long]
        var arrOfMiniMarketModel = [MiniMarketModel]()
        var arrOfMiniMarketCategories = [MiniMarketCategories]()
        var arrOfMiniMarketProducts = [MiniMarketProducts]()
        Alamofire.request(DisplayMiniMarket_Url, method: .post, parameters: params , encoding: URLEncoding.default , headers: nil).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                if let json = try? JSON(data: data) {
                    let arrjson = json.array
                    for item in arrjson! {
                        
                        let market_id = item["product_id_fk"].stringValue
                        let name = item["market_name"].stringValue
                        let phone = item["market_phone"].stringValue
                        let _lat =  item["market_google_lat"].stringValue
                        let _long = item["market_google_long"].stringValue
                        let city = item["market_city"].stringValue
                        let photo = item["market_photo"].stringValue
                        let delivery_cost = item["delivery_cost"].stringValue
                        let distance = item["distance"].doubleValue
                        let minimarketcategories = item["sub_categories"].array
                      
                        arrOfMiniMarketCategories.removeAll()
                        for category in minimarketcategories! {
                            
                            let idcategories = category["id_categories"].stringValue
                            let namecategories = category["name_categories"].stringValue
                            let image_categories = category["image_categories"].stringValue
                            let minimarketproducts = category["sub_product"].array
                            
                            arrOfMiniMarketProducts.removeAll()
                            for product in minimarketproducts! {
                                let idproduct    = product["id_product"].stringValue
                                let producttitle = product["product_title"].stringValue
                                let productimage = product["product_image"].stringValue
                                let productprice = product["product_price"].stringValue
                                let productcontent = product["product_content"].stringValue
                                
                                arrOfMiniMarketProducts.append(MiniMarketProducts(idproduct: idproduct, producttitle: producttitle, productimage: productimage, productprice: productprice, productcontent: productcontent))
                            }
                            
                            arrOfMiniMarketCategories.append(MiniMarketCategories(idcategories: idcategories, namecategories: namecategories, imagecategories: image_categories, minimarketproducts: arrOfMiniMarketProducts))
                            
                        
                        }
                        
                        NotificationCenter.default.post(name: Notification.Name.categoriesOfMiniMarket, object: arrOfMiniMarketCategories)
                        
                           arrOfMiniMarketModel.append(MiniMarketModel(marketid: market_id, marketname: name, marketphone: phone, marketgooglelat: _lat, marketgooglelong: _long, marketcity: city, marketphoto: photo, deliverycost: delivery_cost, distance: distance, minimarketcategories: arrOfMiniMarketCategories))
                        
                     
                        
                        
                    }
                    NotificationCenter.default.post(name: Notification.Name.miniMarketNotification, object: arrOfMiniMarketModel)
                    completion(true)
                }}
            print("response of mini market \(response)")
            completion(false)
        }
    }
}
