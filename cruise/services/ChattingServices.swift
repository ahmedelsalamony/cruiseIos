//
//  ChattingServices.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/12/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ChattingServices {
    
     static let instance = ChattingServices()
    
    func getChatRoom( completion : @escaping completionHandler){
        
        let myId = UserDefaults.standard.value(forKey: "userId") as? String
        let roomId = UserDefaults.standard.value(forKey: "roomId") as? String
        var arrOfChats = [ChattingRoomModel]()
        Alamofire.request(ChatRoom_Url+"\(roomId ?? "")", method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                if response.result.error == nil {
               
                    guard let data = response.data else {return}
                    
                    if let json = try? JSON(data: data) {
                       
                        let listOfChats = json.array
                     
                        for item in listOfChats!{
                            
                            arrOfChats.append(ChattingRoomModel(idmsg: item["id_message"].stringValue, roomid: item["room_id_fk"].stringValue, msgtype: item["message_type"].stringValue, img: item["image"].stringValue, msg: item["message"].stringValue, fname: item["from_name"].stringValue, fid: item["from_id"].stringValue, ftype: item["from_type"].stringValue, fphoto: item["from_photo"].stringValue, tname: item["to_name"].stringValue, tid: item["to_id"].stringValue, ttype: item["to_type"].stringValue, tphoto: item["to_photo"].stringValue, msgdate: item["message_date"].stringValue, msgtime: item["message_time"].stringValue))
                        
                            if (item["from_id"].stringValue != myId ){
                                 UserDefaults.standard.set(item["from_id"].stringValue, forKey: "toId")
                            }
                        }
                        
                        
                          print("chat in services :: ##3 \(arrOfChats.count)")
                        completion(true)
                       NotificationCenter.default.post(name: Notification.Name.ChatRoomNotification, object: arrOfChats)
                    }
                }
        }
    }
   
    func sendMsg(msg : String,completion : @escaping completionHandler){
         let roomId = UserDefaults.standard.value(forKey: "roomId") as? String
        let myId = UserDefaults.standard.value(forKey: "userId") as? String
        let toId = UserDefaults.standard.value(forKey: "toId") as? String
        let params : [String:Any] = ["from_id":myId!,"to_id":toId!,"message":msg,"message_type":"text"]
        Alamofire.request(SendMsg_Url+"\(roomId ?? "")", method: .post, parameters: params, encoding: URLEncoding.default, headers: URLEncodHeader).responseJSON { response in
            if response.result.error == nil {
                guard let data = response.data else {return}
                if let json = try? JSON(data: data) {
                 
                    let msgresult = ChattingRoomModel(idmsg: json["id_message"].stringValue, roomid: json["room_id_fk"].stringValue, msgtype: json["message_type"].stringValue, img: json["image"].stringValue, msg: json["message"].stringValue, fname: json["from_name"].stringValue, fid: json["from_id"].stringValue, ftype: json["from_type"].stringValue, fphoto: json["from_photo"].stringValue, tname: json["to_name"].stringValue, tid: json["to_id"].stringValue, ttype: json["to_type"].stringValue, tphoto: json["to_photo"].stringValue, msgdate: json["message_date"].stringValue, msgtime: json["message_time"].stringValue, successSend: json["message_time"].intValue)
                    
                     NotificationCenter.default.post(name: Notification.Name.SendMsgNotification, object: msgresult)
               
                }
            }else {
                completion(false)
            }
        }
    }
    
}

