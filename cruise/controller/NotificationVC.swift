//
//  NotificationVC.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/2/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tableviewnotification: UITableView!
    //vars
    var _arrOfClientAlerts = [AlertsModel]()
    var clientphoto = ""
    var clientname = ""
    var clientaddress = ""
    var orderdate = ""
    var totalprice = ""
    var billproducts = [BillProducts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //1 >> client
        //2 >> driver
        //3 >> grocery
        let userId = UserDefaults.standard.value(forKey: "userId") as? String
        let userType = UserDefaults.standard.value(forKey: "userType") as? String
        if (userType == "1"){
            self.tableviewnotification.register(UINib(nibName: "ClientNotificationsCell", bundle: nil), forCellReuseIdentifier: "clientalertcell")
            NotificationServices.instance.getClientAlerts(userId: userId!) { (success) in
            }
            NotificationCenter.default.addObserver(self, selector: #selector(getClientAlertsNotification), name: Notification.Name.ClientAlertsNotification , object: nil)
        }else  if (userType == "2"){
            self.tableviewnotification.register(UINib(nibName: "GroceryNotificationsCell", bundle: nil), forCellReuseIdentifier: "grocerynotificationscell")
            NotificationServices.instance.getDriverAlerts(userId: userId!) { (Bool) in
            }
            NotificationCenter.default.addObserver(self, selector: #selector(getDriverAlertsNotification), name: Notification.Name.DriverAlertNotification , object: nil)
        }else if (userType == "3"){
            self.tableviewnotification.register(UINib(nibName: "GroceryNotificationsCell", bundle: nil), forCellReuseIdentifier: "grocerynotificationscell")
            NotificationServices.instance.getGroceryAlerts(userId: userId!) { (Bool) in
            }
            NotificationCenter.default.addObserver(self, selector: #selector(getGroceryAlertsNotification), name: Notification.Name.GroceryAlertNotification , object: nil)
            
        }
        tableviewnotification.delegate = self
        tableviewnotification.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._arrOfClientAlerts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userType = UserDefaults.standard.value(forKey: "userType") as? String
        if (userType == "1"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "clientalertcell", for: indexPath) as! ClientNotificationsCell
            cell.setupData(model: _arrOfClientAlerts[indexPath.row])
            return cell
        }else  if (userType == "2"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "grocerynotificationscell", for: indexPath) as! GroceryNotificationsCell
            cell.setupData(model : _arrOfClientAlerts[indexPath.row])
            return cell
        }else if (userType == "3"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "grocerynotificationscell", for: indexPath) as! GroceryNotificationsCell
            cell.setupData(model : _arrOfClientAlerts[indexPath.row])
            return cell
        }
         return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userType = UserDefaults.standard.value(forKey: "userType") as? String
        if (userType == "1"){
            
            
            
        }else  if (userType == "2"){
            clientphoto = _arrOfClientAlerts[indexPath.row].clientPhoto!
            clientname  = _arrOfClientAlerts[indexPath.row].clientName!
            clientaddress = _arrOfClientAlerts[indexPath.row].billAddress!
            orderdate = _arrOfClientAlerts[indexPath.row].deliveryOrderTime!
            totalprice = _arrOfClientAlerts[indexPath.row].billCost!
            billproducts = _arrOfClientAlerts[indexPath.row].billProducts!
            performSegue(withIdentifier: "fromgrocerynotification", sender: self)
        }else if (userType == "3"){
            clientphoto = _arrOfClientAlerts[indexPath.row].clientPhoto!
            clientname  = _arrOfClientAlerts[indexPath.row].clientName!
            clientaddress = _arrOfClientAlerts[indexPath.row].billAddress!
            orderdate = _arrOfClientAlerts[indexPath.row].deliveryOrderTime!
            totalprice = _arrOfClientAlerts[indexPath.row].billCost!
            billproducts = _arrOfClientAlerts[indexPath.row].billProducts!
            performSegue(withIdentifier: "fromgrocerynotification", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fromgrocerynotification"){
            var vc = segue.destination as! GroceryNotificationDetailsVC
            vc.clientname = self.clientname
            vc.clientphoto = self.clientphoto
            vc.clientaddress = self.clientaddress
            vc.orderdate = self.orderdate
            vc.totalprice = self.totalprice
            vc.billproducts = self.billproducts
        }
    }
    
    @objc func getClientAlertsNotification(_ notification: Notification){
        let arrOfClientAlerts = notification.object as? [AlertsModel]
        for alert in arrOfClientAlerts! {
            self._arrOfClientAlerts.append(alert)
        }
        //must reload tableview here
        self.tableviewnotification.reloadData()
    }
    
    
    @objc func getGroceryAlertsNotification(_ notification: Notification){
        let arrOfClientAlerts = notification.object as? [AlertsModel]
        for alert in arrOfClientAlerts! {
            self._arrOfClientAlerts.append(alert)
        }
        //must reload tableview here
        self.tableviewnotification.reloadData()
    }
    
    @objc func getDriverAlertsNotification(_ notification: Notification){
        let arrOfClientAlerts = notification.object as? [AlertsModel]
        for alert in arrOfClientAlerts! {
            self._arrOfClientAlerts.append(alert)
        }
        //must reload tableview here
        self.tableviewnotification.reloadData()
    }
}
