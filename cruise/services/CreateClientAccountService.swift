//
//  CreateClientAccountService.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/13/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData

class CreateClientAccountService  {
    
     static let instance = CreateClientAccountService()
    
    func createAccount(model : ClientModel, completion : @escaping completionHandler ){
        print("in createAccount")
        let params : [String:Any] = ["user_name":model.name,"user_pass":model.password,"user_phone":model.phone,
                                     "user_full_name":model.name,"user_token_id":"",
                                     "user_google_lat":model.latitude,"user_google_long":model.longitude,
                                     "user_email":model.email,"user_photo_send":model.withImage,
                                     "user_photo":model.profileImage]
        print("params are \(params)")
        Alamofire.request(createClientAccount_Url, method: .post, parameters: params, encoding:URLEncoding.default , headers: URLEncodHeader).responseString { (response) in
            
            if response.result.error == nil {
                completion(true)
                guard let data = response.data else {return}
                if let json = try? JSON(data: data) {
                    print("result of register \(json)")
                    
                    UserDefaults.standard.set(json["user_id"].stringValue, forKey: "userId")
                    UserDefaults.standard.set(json["user_name"].stringValue, forKey: "userName")
                    UserDefaults.standard.set(json["is_login"].stringValue, forKey: "isLogin")
                    UserDefaults.standard.set(json["user_pass"].stringValue, forKey: "userPass")
                    UserDefaults.standard.set(json["user_type"].stringValue, forKey: "userType")
                    UserDefaults.standard.set(json["user_full_name"].stringValue, forKey: "userFullName")
                    UserDefaults.standard.set(json["user_phone"].stringValue, forKey: "userPhone")
                     UserDefaults.standard.set(json["user_email"].stringValue, forKey: "userEmail")

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
                
                    
//                    if json["success"].int16Value == 1 {
//                        completion(true)
//                    } else if json["success"].int16Value == 2 {
//                        completion(false)
//                    }
                   
                }
            } else if response.result.error != nil {
                completion(false)
            }
        
            print("sdsadasda  sadasd  asdasd  \(response)")
        }
    }
}
