//
//  GroceryNotificationDetailsVC.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/3/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import UIKit

class GroceryNotificationDetailsVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
  
    @IBOutlet weak var viewcontainer: UIView!
    @IBOutlet weak var ivclientphoto: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lbladdress: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var tableviewbillproducts: UITableView!
    
    //vars
    var clientphoto = ""
    var clientname = ""
    var clientaddress = ""
    var orderdate = ""
    var totalprice = ""
    var billproducts = [BillProducts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewcontainer.layer.cornerRadius = 3
        viewcontainer.layer.masksToBounds = false
        viewcontainer.layer.shadowColor = UIColor.lightGray.cgColor
        viewcontainer.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        viewcontainer.layer.shadowOpacity = 0.8
        lblname.text = clientname
        lbladdress.text = clientaddress
        lbldate.text = orderdate
        lblprice.text = totalprice + " SAR"
        ivclientphoto.sd_setImage(with: URL(string: Images_Url + clientphoto)) { (image, error, cache, urls) in
            if (error != nil) {
                self.ivclientphoto.image = UIImage(named: "bg")
            } else {
                self.ivclientphoto.image = image
            }
        }
        ivclientphoto.layer.cornerRadius = ivclientphoto.frame.width / 2
        ivclientphoto.clipsToBounds = true
        self.tableviewbillproducts.register(UINib(nibName: "GroceryNotificationBillProductsCell", bundle: nil), forCellReuseIdentifier: "billproductcell")
        self.tableviewbillproducts.delegate = self
        self.tableviewbillproducts.dataSource = self
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billproducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "billproductcell", for: indexPath) as! GroceryNotificationBillProductsCell
        cell.setupdata(model : billproducts[indexPath.row])
        return cell
    }
    
    

}
