//
//  ChatRoomVC.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/12/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import UIKit

class ChatRoomVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    @IBOutlet weak var tablechatroom: UITableView!
    
    //vars
    var arrOfChat = [ChattingRoomModel]()
    
    @IBOutlet weak var tvmessage: UITextField!
   
    func setupNavigationBarStyle(){
        navigationItem.title = "Chat"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tablechatroom.register(ChatTableViewCell.self, forCellReuseIdentifier: "cellId")
        self.tablechatroom.delegate = self
        self.tablechatroom.dataSource = self
        tablechatroom.transform = CGAffineTransform(rotationAngle: (-.pi))
        
        ChattingServices.instance.getChatRoom { (success) in
        }
        
        
         NotificationCenter.default.addObserver(self, selector: #selector(getChat), name: Notification.Name.ChatRoomNotification , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getMsgResult), name: Notification.Name.SendMsgNotification, object: nil)
        
        self.tablechatroom.reloadData()
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        ChattingServices.instance.sendMsg( msg: tvmessage.text!) { (success) in
        }
    }
    
    @objc func getChat(_ notification: Notification){
        if let myDict = notification.object as? [ChattingRoomModel] {
            for item in myDict {
                if (item.message != "0"){
              arrOfChat.append(ChattingRoomModel(idmsg: item.id_message!, roomid: item.room_id_fk!, msgtype: item.message_type!, img: item.image!, msg: item.message!, fname: item.from_name!, fid: item.from_id!, ftype: item.from_type!, fphoto: item.from_photo!, tname: item.to_name!, tid: item.to_id!, ttype: item.to_type!, tphoto: item.to_photo!, msgdate: item.message_date!, msgtime: item.message_time!))
                }
            }
        }
        self.tablechatroom.reloadData()
    }
    
    @objc func getMsgResult(_ notification : Notification){
          let myId = UserDefaults.standard.value(forKey: "userId") as? String
          if let myDict = notification.object as? ChattingRoomModel {
            if myDict.from_id != myId {
                 if (myDict.message != "0"){
                arrOfChat.append(ChattingRoomModel(idmsg: myDict.id_message!, roomid: myDict.room_id_fk!, msgtype: myDict.message_type!, img: myDict.image!, msg: myDict.message!, fname: myDict.from_name!, fid: myDict.from_id!, ftype: myDict.from_type!, fphoto: myDict.from_photo!, tname: myDict.to_name!, tid: myDict.to_id!, ttype: myDict.to_type!, tphoto: myDict.to_photo!, msgdate: myDict.message_date!, msgtime: myDict.message_time!))
                }}
        }
          self.tablechatroom.reloadData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfChat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ChatTableViewCell
        cell.transform = CGAffineTransform(rotationAngle: (-.pi))
        let chatmodel = arrOfChat[indexPath.row]
        cell.chatmodel = chatmodel
        return cell
    }
    
    
}
