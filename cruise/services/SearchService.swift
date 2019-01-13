//
//  SearchService.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/24/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SearchService {
    
    static let instance = SearchService()
    
    func getSearchResult(searchkey : String , completion : @escaping completionHandler){
       var arrOfSearchResult = [SearchModel]()
        let params : [String:Any] = ["searh_title":searchkey]
         Alamofire.request(search_Url, method: .post, parameters: params, encoding:URLEncoding.default , headers: URLEncodHeader).responseJSON { (response) in
        
            if response.result.error == nil {
                completion(true)
                guard let data = response.data else {return}
                if let json = try? JSON(data: data) {
                  
                    let jsonarr = json.array
                    for item in jsonarr! {
                    
                       arrOfSearchResult.append(SearchModel(product_id: item["product_id_fk"].stringValue, is_admin: item["is_admin"].stringValue, main_department: item["main_department_fk"].stringValue, market_id: item["market_id_fk"].stringValue, product_cost: item["product_cost"].stringValue, categories_name: item["categories_name"].stringValue, id_categories: item["id_categories"].stringValue, product_name: item["product_name"].stringValue, product_image: item["product_image"].stringValue, product_content: item["product_content"].stringValue, market_name: item["market_name"].stringValue ,market_phone : item["phone"].stringValue , market_google_lat: item["market_google_lat"].stringValue, market_google_long: item["market_google_long"].stringValue, market_city: item["market_city"].stringValue, market_photo: item["market_photo"].stringValue, delivery_cost: item["delivery_cost"].stringValue))
                        
                    }
                 
                    NotificationCenter.default.post(name: Notification.Name.searchResultNotification, object: arrOfSearchResult)
                }
            } else if response.result.error != nil {
                completion(false)
            }
        }
    }
    
}
