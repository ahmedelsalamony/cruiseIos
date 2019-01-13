//
//  CreateGroceryAccountService.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/14/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//
import Foundation
import SwiftyJSON
import Alamofire
import CoreData

class CreateGroceryAccountService {
    
    static let instance = CreateGroceryAccountService()
    
    func createGroceryAccount(model : ClientModel ,completion : @escaping completionHandler){
        
        let params : [String:Any] = ["user_name":model.name,"user_pass":model.password,"user_phone":model.phone,
                                     "user_full_name":model.name,"user_token_id":model.deviceToken,
                                     "user_google_lat":model.latitude,"user_google_long":model.longitude,
                                     "user_email":model.email,"user_work_hours":model.user_workhours,
                                     "user_photo":"","my_products[]":[1,3]]
       Alamofire.request(GroceryRegistration_Url, method: .post, parameters: params, encoding: URLEncoding.default, headers: URLEncodHeader).responseString { (response) in
        
        if response.result.error == nil {
            
            guard let data = response.data else {return}
            if let json = try? JSON(data: data) {
                print("result of register \(json)")
           
                  //save in user defaults
                
//                newUser.user_id = json["user_id"].stringValue
//                newUser.user_name = json["user_name"].stringValue
//                newUser.is_login = json["is_login"].stringValue
//                newUser.user_pass = json["user_pass"].stringValue
//                newUser.user_type = json["user_type"].stringValue
//                newUser.user_full_name = json["user_full_name"].stringValue
//                newUser.user_phone = json["user_phone"].stringValue
//                newUser.user_email = json["user_email"].stringValue
//                newUser.user_photo = json["user_photo"].stringValue
//                newUser.user_token_id = json["user_token_id"].stringValue
//                newUser.user_google_lat = json["user_google_lat"].stringValue
//                newUser.user_google_long = json["user_google_long"].stringValue
//                newUser.user_city = json["user_city"].stringValue
//                newUser.date_registration = json["date_registration"].stringValue
//                newUser.user_license_photo = json["user_license_photo"].stringValue
//                newUser.user_car_photo = json["user_car_photo"].stringValue
//                newUser.user_residence_photo = json["user_residence_photo"].stringValue
//                newUser.user_neighborhood = json["user_neighborhood"].stringValue
//                newUser.user_work_hours = json["user_work_hours"].stringValue
//                newUser.success = json["success"].int16Value
                
                
//                //update value in core data
//                let fechrequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Users")
//
//                do {
//                    let test = try PersistanceManager.persistentContainer.viewContext.fetch(fechrequest)
//                    let objectUpdate = test[0] as! NSManagedObject
//                    objectUpdate.setValue(json["user_id"].stringValue, forKey: "user_id")
//                    objectUpdate.setValue(json["user_name"].stringValue, forKey: "user_name")
//                    objectUpdate.setValue(json["is_login"].stringValue, forKey: "is_login")
//                    objectUpdate.setValue(json["user_pass"].stringValue, forKey: "user_pass")
//                    objectUpdate.setValue(json["user_type"].stringValue, forKey: "user_type")
//                    objectUpdate.setValue(json["user_full_name"].stringValue, forKey: "user_full_name")
//                    objectUpdate.setValue(json["user_phone"].stringValue, forKey: "user_phone")
//                    objectUpdate.setValue(json["user_email"].stringValue, forKey: "user_email")
//                    objectUpdate.setValue(json["user_photo"].stringValue, forKey: "user_photo")
//                    objectUpdate.setValue(json["user_token_id"].stringValue, forKey: "user_token_id")
//                    objectUpdate.setValue(json["user_google_lat"].stringValue, forKey: "user_google_lat")
//                    objectUpdate.setValue(json["user_google_long"].stringValue, forKey: "user_google_long")
//                    objectUpdate.setValue(json["user_city"].stringValue, forKey: "user_city")
//                    objectUpdate.setValue(json["date_registration"].stringValue, forKey: "date_registration")
//                    objectUpdate.setValue(json["user_license_photo"].stringValue, forKey: "user_license_photo")
//                    objectUpdate.setValue(json["user_car_photo"].stringValue, forKey: "user_car_photo")
//                    objectUpdate.setValue(json["user_residence_photo"].stringValue, forKey: "user_residence_photo")
//                    objectUpdate.setValue(json["user_neighborhood"].stringValue, forKey: "user_neighborhood")
//                    objectUpdate.setValue(json["user_work_hours"].stringValue, forKey: "user_work_hours")
//                    objectUpdate.setValue(json["success"].int16Value, forKey: "success")
//                    do {
//                        try PersistanceManager.persistentContainer.viewContext.save()
//                    } catch {}
//
//                }catch{
//                }
                
                if json["success"].int16Value == 1 {
                    completion(true)
                } else if json["success"].int16Value == 2 {
                    completion(false)
                }
            }
            
        } else {
            
        }
        print("rrrr   \(response)")
        }
    }

    func getAllDepartmentProducts(completion : @escaping completionHandler){
        var arrOfCategories = [DepartmentProductCategory]()
        var arrOfSubCategory = [SubProductModel]()
        Alamofire.request(DepartmentProducts_Url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else {return}
                if let json = try? JSON(data: data){
                       print("jsonnnnn  \(json)")
                       let arrjson = json.array
                    for item in arrjson! {
                       let arrsubjson = item["sub_product"].array

                        for subitem in arrsubjson! {
                            arrOfSubCategory.append(SubProductModel(id: subitem["id_product"].stringValue, title: subitem["product_title"].stringValue, img: subitem["product_image"].stringValue, price: subitem["product_price"].stringValue))
                        }

                        arrOfCategories.append(DepartmentProductCategory(id_categories: item["id_categories"].stringValue, name_categories: item["name_categories"].stringValue, image_categories: item["image_categories"].stringValue, expanded: true, sub_product: arrOfSubCategory))
                        
                        arrOfSubCategory.removeAll()
                    }
                    
                    NotificationCenter.default.post(name: Notification.Name.DepartCategoriesNotification, object: arrOfCategories)
                    
                    NotificationCenter.default.post(name: Notification.Name.DeprtSubCategoriesNotification, object: arrOfSubCategory)
                }
            }
        }
    }
    
}

