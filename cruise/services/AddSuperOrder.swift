//
//  AddSuperOrder.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/10/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AddSuperOrder {
    
    static let instance = AddSuperOrder()
    
    func sendSuperOrder(params : [[String:Any]],completion : @escaping completionHandler){
     
        let url = URL(string: addSuperMarketOrder)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: params)
        
        Alamofire.request(request)
            .responseJSON { response in
                // do whatever you want here
                switch response.result {
                case .failure(let error):
                    print(error)
                    completion(false)
                    
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                        print(responseString)
                    }
                case .success(let responseObject):
                    print("checkout response  : : :  \(responseObject)")
                    completion(true)
                }
        }
    }
    
    
    
}
