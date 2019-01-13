//
//  LoginServices.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/22/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class LoginServices {
    
    static let instance = LoginServices()
    
    func login(username : String , password : String ,completion : @escaping completionHandler){
        
        let params : [String : Any] = ["user_name":username.replacingOccurrences(of: "\"", with: ""),"user_pass":password.replacingOccurrences(of: "\"", with: "")]
        print("params is :: \(params)")
        Alamofire.request(Login_Url, method: .post, parameters: params, encoding:URLEncoding.default , headers: URLEncodHeader).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else {return}
                print("result of register \(data)")
                if let json = try? JSON(data: data) {
                    print("result of register \(json)")
                    // save in user defaults
                    UserDefaults.standard.set(json["user_id"].stringValue, forKey: "userId")
                    UserDefaults.standard.set(json["user_name"].stringValue, forKey: "userName")
                    UserDefaults.standard.set(json["is_login"].stringValue, forKey: "isLogin")
                    UserDefaults.standard.set(json["user_pass"].stringValue, forKey: "userPass")
                    UserDefaults.standard.set(json["user_type"].stringValue, forKey: "userType")
                    UserDefaults.standard.set(json["user_phone"].stringValue, forKey: "userPhone")
                    UserDefaults.standard.set(json["user_email"].stringValue, forKey: "userEmail")
                    UserDefaults.standard.set(json["user_photo"].stringValue, forKey: "userPhoto")
                    UserDefaults.standard.set(json["user_token_id"].stringValue, forKey: "userTokenId")
                    UserDefaults.standard.set(json["user_city"].stringValue, forKey: "userCity")
                    UserDefaults.standard.set(json["user_id"].stringValue, forKey: "userId")
                    //                    newUser.user_license_photo = json["user_license_photo"].stringValue
                    //                    newUser.user_car_photo = json["user_car_photo"].stringValue
                    //                    newUser.user_residence_photo = json["user_residence_photo"].stringValue
                    //                    newUser.user_neighborhood = json["user_neighborhood"].stringValue
                    //                    newUser.user_work_hours = json["user_work_hours"].stringValue
                    //                    newUser.success = json["success"].int16Value
                    if json["success"].int16Value == 1 {
                        completion(true)
                    } else if json["success"].int16Value == 0 {
                        completion(false)
                    }
                }
            } else if response.result.error != nil {
                
            }
            print("login result :: \(response)")
        }
    }
    
    func updateTokenId(userId : String ,completion : @escaping completionHandler ){
        
        let params : [String:Any] = ["user_token_id":UserDefaults.standard.value(forKey: "userTokenId") as Any ]
        Alamofire.request(UpdateTokenId_Url, method: .post, parameters: params, encoding:URLEncoding.default , headers: URLEncodHeader).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                if let json = try? JSON(data: data) {
                    let result = json["success"].intValue
                    print("result of rerer \(result) ")
                    completion(true)
                }
            }else {
                completion(false)
            }
        }
    }
    
    func resetPassword(username : String , email : String ,completion : @escaping completionHandler){
        let params : [String : Any] = ["user_name":username.replacingOccurrences(of: "\"", with: ""),"user_email":email.replacingOccurrences(of: "\"", with: "")]
        print("params is :: \(params)")
        Alamofire.request(ResetPassword_Url, method: .post, parameters: params, encoding:URLEncoding.default , headers: URLEncodHeader).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                if let json = try? JSON(data: data) {
                    let result = json["success"].intValue
                    print("result of rerer \(result) ")
                    NotificationCenter.default.post(name: Notification.Name.resetPassResultNotification, object: result)
                    completion(true)
                }
            }else {
                completion(false)
            }
        }
    }
    
    func logout(completion : @escaping completionHandler){
        let myId = UserDefaults.standard.string(forKey: "userId") ?? ""
        Alamofire.request(Logout_Url+"\(myId)", method: .get,encoding: JSONEncoding.default).responseJSON { (response) in
            if response.result.error == nil {
                completion(true)
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
            }else {
                completion(false)
            }
        }
    }
    
    func contactUs(completion : @escaping completionHandler){
        Alamofire.request(ContactUs_Url, method: .get,encoding: JSONEncoding.default).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                if let json = try? JSON(data: data) {
                completion(true)
                let whatsapp = json["whatsapp"].stringValue
                let email = json["email"].stringValue
                UserDefaults.standard.set(whatsapp, forKey: "whatsapp")
                UserDefaults.standard.set(email, forKey: "email")
                }
            }else {
                completion(false)
            }
        }
    }
    
    func sendcWithContactUs(name : String , email : String , subject : String , message : String , completion : @escaping completionHandler){
        let params : [String : Any] = ["name":name.replacingOccurrences(of: "\"", with: ""),"email":email.replacingOccurrences(of: "\"", with: ""),"subject" : subject.replacingOccurrences(of: "\"", with: ""), "message" : message.replacingOccurrences(of: "\"", with: "")]
        Alamofire.request(ContactUs_Url, method: .post, parameters: params, encoding:URLEncoding.default , headers: URLEncodHeader).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                if let json = try? JSON(data: data) {
                    let result = json["success"].intValue
                    print("result of rerer \(result) ")
                    if result == 1 {
                          completion(true)
                    } else {
                         completion(false)
                    }
                }
            }else {
                completion(false)
            }
        }
    }
    
    func appTerms( completion : @escaping completionHandler){
        Alamofire.request(Terms_Url, method: .get,encoding: JSONEncoding.default).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                if let json = try? JSON(data: data) {
                    completion(true)
                    let content = json["content"].stringValue
                     NotificationCenter.default.post(name: Notification.Name.TermsNotification, object: content)
                }
            }else {
                completion(false)
            }
        }
    }
    
    
    
}
