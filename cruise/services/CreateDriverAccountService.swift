//
//  CreateDriverAccountService.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/15/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CreateDriverAccountService {
    
    static let instance = CreateDriverAccountService()
    
    func createAccount(model : ClientModel, completion : @escaping completionHandler ){
        
        let params : [String:Any] = ["user_name":model.name,"user_pass":model.password,"user_phone":model.phone,
                                     "user_full_name":model.name,"user_token_id":"",
                                     "user_google_lat":model.latitude,"user_google_long":model.longitude,
                                     "user_email":model.email,
                                     "user_neighborhood":"ryad","user_city":"first",
                    "user_photo":model.profileImage,"user_license_photo":model.user_license_photo ?? ""
            ,"user_car_photo":model.user_car_photo ?? "","user_residence_photo":model.user_residence_photo ?? ""]
       
      
        Alamofire.request(DriverRegistration_Url, method: .post, parameters: params, encoding:URLEncoding.default , headers: URLEncodHeader).responseJSON { (response) in
            
            if response.result.error == nil {
           
                guard let data = response.data else {return}
                print("result of register \(data)")
                if let json = try? JSON(data: data) {
                    print("result of register \(json)")
                    //save in user defaults
                    
//                    newUser.user_id = json["user_id"].stringValue
//                    newUser.user_name = json["user_name"].stringValue
//                    newUser.is_login = json["is_login"].stringValue
//                    newUser.user_pass = json["user_pass"].stringValue
//                    newUser.user_type = json["user_type"].stringValue
//                    newUser.user_full_name = json["user_full_name"].stringValue
//                    newUser.user_phone = json["user_phone"].stringValue
//                    newUser.user_email = json["user_email"].stringValue
//                    newUser.user_photo = json["user_photo"].stringValue
//                    newUser.user_token_id = json["user_token_id"].stringValue
//                    newUser.user_google_lat = json["user_google_lat"].stringValue
//                    newUser.user_google_long = json["user_google_long"].stringValue
//                    newUser.user_city = json["user_city"].stringValue
//                    newUser.date_registration = json["date_registration"].stringValue
//                    newUser.user_license_photo = json["user_license_photo"].stringValue
//                    newUser.user_car_photo = json["user_car_photo"].stringValue
//                    newUser.user_residence_photo = json["user_residence_photo"].stringValue
//                    newUser.user_neighborhood = json["user_neighborhood"].stringValue
//                    newUser.user_work_hours = json["user_work_hours"].stringValue
//                    newUser.success = json["success"].int16Value
                  
                    
                    if json["success"].int16Value == 1 {
                        completion(true)
                    } else if json["success"].int16Value == 2 {
                        completion(false)
                    }
                }
            } else if response.result.error != nil {
               
            }
        }
    }
}
