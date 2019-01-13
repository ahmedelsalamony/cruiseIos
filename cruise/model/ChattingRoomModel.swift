//
//  ChattingRoomModel.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/12/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import Foundation

struct ChattingRoomModel {
    
    
    var id_message : String?
    var room_id_fk : String?
    var message_type : String?
    var image : String?
    var message : String?
    var from_name : String?
    var from_id : String?
    var from_type : String?
    var from_photo : String?
    var to_name : String?
    var to_id : String?
    var to_type : String?
    var to_photo : String?
    var message_date : String?
    var message_time : String?
    var successSend : Int?
    
    init(idmsg : String? = nil,roomid : String? = nil,msgtype : String? = nil,img : String? = nil,msg : String? = nil,fname : String,fid : String,ftype : String,fphoto:String,tname:String,tid:String,ttype:String,tphoto:String,msgdate:String,msgtime:String,successSend : Int? = nil) {
        self.id_message = idmsg
        self.room_id_fk = roomid
        self.message_type = msgtype
        self.image = img
        self.message = msg
        self.from_name = fname
        self.from_id = fid
        self.from_type = ftype
        self.from_photo = fphoto
        self.to_name = tname
        self.to_id = tid
        self.to_type = ttype
        self.to_photo = tphoto
        self.message_date = msgdate
        self.message_time = msgtime
        self.successSend = successSend
    }
    
}
