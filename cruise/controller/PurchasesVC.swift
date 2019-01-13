//
//  PurchasesVC.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/4/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import UIKit

class PurchasesVC: UIViewController ,UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var segmentorderstate: UISegmentedControl!
    @IBOutlet weak var tablevieworders: UITableView!
    
    //vars
    var _arrOfCurrentOrders = [MyOrdersModel]()
    var _arrOfPreviousOrders = [MyOrdersModel]()
    var _arrOfDriverGroceryOrders = [DriverGroceryModel]()
    var _arrOfOrders = [MyOrdersModel]()
    var clientphoto = ""
    var clientname = ""
    var clientaddress = ""
    var orderdate = ""
    var totalprice = ""
    var roomId = ""
    var billproducts = [BillProducts]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(0, forKey: "_userOrderState")
        let userType = UserDefaults.standard.value(forKey: "userType") as? String
        let userId = UserDefaults.standard.value(forKey: "userId") as? String
        print("useeee  :: \(userId)")
        self.tablevieworders.register(UINib(nibName: "PurchasesCell", bundle: nil), forCellReuseIdentifier: "clientpurchasecell")
        if (userType == "1"){
        MyOrdersServices.instance.getCurrentClientOrders(userId: userId!.replacingOccurrences(of: "\"", with: "")) { (success) in
        }
        NotificationCenter.default.addObserver(self, selector: #selector(getClientCurrentOrdersNotification), name: Notification.Name.ClientCurrentOrdersNotification , object: nil)
        }else {
            MyOrdersServices.instance.getDriverGroceryOrders(orderstype: String(1), userId: userId!) { (success) in
            }
            NotificationCenter.default.addObserver(self, selector: #selector(getDriverGroceryOrders), name: Notification.Name.DriverGroceryNotification, object: nil)
        }
        self.tablevieworders.reloadData()
        self.tablevieworders.delegate = self
        self.tablevieworders.dataSource = self
    }
    
    @IBAction func segmentedClicked(_ sender: Any) {
        let userId = UserDefaults.standard.value(forKey: "userId") as? String
        let userType = UserDefaults.standard.value(forKey: "userType") as? String
        ////////////////// CURRENT //////////////////////
        if segmentorderstate.selectedSegmentIndex == 0 {
            UserDefaults.standard.set(0, forKey: "_userOrderState")
            if (userType == "1"){
            MyOrdersServices.instance.getCurrentClientOrders(userId: userId!.replacingOccurrences(of: "\"", with: "")) { (success) in
            }
            NotificationCenter.default.addObserver(self, selector: #selector(getClientCurrentOrdersNotification), name: Notification.Name.ClientCurrentOrdersNotification , object: nil)
            }else {
                MyOrdersServices.instance.getDriverGroceryOrders(orderstype: String(1), userId: userId!) { (success) in
                }
                NotificationCenter.default.addObserver(self, selector: #selector(getDriverGroceryOrders), name: Notification.Name.DriverGroceryNotification, object: nil)
            }
            self.tablevieworders.reloadData()
        }else {
            ////////////////// PREVIOUS //////////////////////
            UserDefaults.standard.set(1, forKey: "_userOrderState")
            if(userType == "1"){
            MyOrdersServices.instance.getPreviousClientOrders(userId: userId!.replacingOccurrences(of: "\"", with: "")) { (success) in
            }
            NotificationCenter.default.addObserver(self, selector: #selector(getClientPreviousOrdersNotification), name: Notification.Name.ClientPreviousOrdersNotification, object: nil)
            }else {
                MyOrdersServices.instance.getDriverGroceryOrders(orderstype: String(2), userId: userId!) { (success) in
                }
                NotificationCenter.default.addObserver(self, selector: #selector(getDriverGroceryOrders), name: Notification.Name.DriverGroceryNotification, object: nil)
            }
            self.tablevieworders.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userType = UserDefaults.standard.value(forKey: "userType") as? String
        if (userType == "1"){
            
            
            
        }else  if (userType == "2" || userType == "3"){
            
            clientphoto = _arrOfDriverGroceryOrders[indexPath.row].cleintuserphoto!
            clientname  = _arrOfDriverGroceryOrders[indexPath.row].clientusername!
            clientaddress = _arrOfDriverGroceryOrders[indexPath.row].billaddress!
            orderdate = _arrOfDriverGroceryOrders[indexPath.row].deliveryordertime!
            totalprice = _arrOfDriverGroceryOrders[indexPath.row].billcost!
            billproducts = _arrOfDriverGroceryOrders[indexPath.row].billProducts!
            roomId = _arrOfDriverGroceryOrders[indexPath.row].roomid!
            print("DDD \(clientphoto)  \(clientname)  \(clientaddress)  \(orderdate)  \(totalprice)")
            performSegue(withIdentifier: "frommyorders", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "frommyorders"){
            var vc = segue.destination as! MyOrdersDetailsVC
            vc.clientname = self.clientname
            vc.clientphoto = self.clientphoto
            vc.clientaddress = self.clientaddress
            vc.orderdate = self.orderdate
            vc.totalprice = self.totalprice
            vc.billproducts = self.billproducts
            vc.roomId = self.roomId
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let userType = UserDefaults.standard.value(forKey: "userType") as? String
        if (userType == "2" || userType == "3"){
            return _arrOfDriverGroceryOrders.count
        } else{
        return _arrOfOrders.count
        }}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userType = UserDefaults.standard.value(forKey: "userType") as? String
        if (userType == "2" || userType == "3"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "clientpurchasecell", for: indexPath) as! PurchasesCell
            cell.setupDataForDG(model: _arrOfDriverGroceryOrders[indexPath.row])
            return cell
        } else if (userType == "1"){
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "clientpurchasecell", for: indexPath) as! PurchasesCell
            cell.setupData(model: _arrOfOrders[indexPath.row])
            return cell
   
        }
        else {
            return UITableViewCell()
        }
    }
    
    @objc func getClientCurrentOrdersNotification(_ notification: Notification){
        self._arrOfOrders.removeAll()
        let arrOfOrders = notification.object as? [MyOrdersModel]
        for order in arrOfOrders! {
            self._arrOfOrders.append(order)
        }
        self.tablevieworders.reloadData()
    }
    
    @objc func getClientPreviousOrdersNotification(_ notification : Notification){
        self._arrOfOrders.removeAll()
        let arrOfOrders = notification.object as? [MyOrdersModel]
        for order in arrOfOrders! {
            self._arrOfOrders.append(order)
        }
        self.tablevieworders.reloadData()
    }
   
    @objc func getDriverGroceryOrders(_ notification : Notification){
        self._arrOfDriverGroceryOrders.removeAll()
        let arrOfOrders = notification.object as? [DriverGroceryModel]
        for order in arrOfOrders! {
            self._arrOfDriverGroceryOrders.append(order)
        }
        self.tablevieworders.reloadData()
    }
    
}
