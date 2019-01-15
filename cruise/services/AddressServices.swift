//
//  AddressServices.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/16/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class AddressServices {
    
    static let instance = AddressServices()
    
    func getCities(completion : @escaping completionHandler){
        var arrcities = [CityAreaModel]()
        var arrarea  = [AreasModel]()
        Alamofire.request(CityArea_Url, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                if response.result.error == nil {
                    guard let data = response.data else {return}
                    if let json = try? JSON(data: data) {
                     let areas = json["sub_areas"].array
                        for area in areas!{
                          arrarea.append(AreasModel(areaid: area["id_area"].stringValue, areatitle: area["area_title"].stringValue))
                        }
                        arrcities.append(CityAreaModel(cityid: json["city_id"].stringValue, citytitle: json["city_title"].stringValue, arrOfAreas: arrarea))
                    
                    NotificationCenter.default.post(name: Notification.Name.CityAreaNotification, object: arrcities)
                    }
                }
        }
    }
}
