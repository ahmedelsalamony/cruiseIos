//
//  SendOrderServices.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/23/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class SendOrdersServices {
    
    static let instance = SendOrdersServices()
    
    func sendOrdersServices(params : [[String:Any]] , completion : @escaping completionHandler){
        
        
        let url = URL(string: addSuperOrder_Url)
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
                        print("OROROROR  \(responseString)")
                    }
                case .success(let responseObject):
                    print("OROROROR  checkout response  : : :  \(responseObject)")
                    completion(true)
                }
        }
    }
}
