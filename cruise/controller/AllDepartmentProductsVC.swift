//
//  AllDepartmentProductsVC.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/14/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit
import BEMCheckBox



class AllDepartmentProductsVC: UIViewController   {
   
    
    @IBOutlet weak var productsTableView: UITableView!
    var arrOfCategories = [DepartmentProductCategory]()
    var arrOfSubCategories = [SubProductModel]()
    let expandcell = ExpandableViewCell()
    var stateSelected = false
    var headerSelected  : Int?
    var cellSelected : Int?
    var selectedArrOfCategories = [DepartmentProductCategory]()
    var selectedArrOfSubCategories = [SubProductModel]()
    var str_profileImg : String = ""
    var groceryname : String = ""
    var availablehours : String = ""
    var phone : String = ""
    var email : String = ""
    var pass : String = ""
    var confirmpass : String = ""
    var myproducts = [MyProducts]()
    
//    func setupNavigationBarStyle(){
//        //change navigation color and tab bar text color
//        navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 0, green: 122, blue: 255)
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor :UIColor.white]
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  //      setupNavigationBarStyle()
        CreateGroceryAccountService.instance.getAllDepartmentProducts { (success) in
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(getCategories), name: Notification.Name.DepartCategoriesNotification , object: nil)
    }
    
    @IBAction func approveItemsBtnClicked(_ sender: Any) {
        let latitude = UserDefaults.standard.string(forKey: "latitude") ?? ""
        let longitude = UserDefaults.standard.string(forKey: "longitude") ?? ""
        
        for (index,item) in arrOfCategories.enumerated() {
            if index == headerSelected {
            for (subindex,subitem) in item.sub_product.enumerated() {
                if subindex == cellSelected {
                selectedArrOfSubCategories.append(SubProductModel(id: subitem.id_product, title: subitem.product_title, img: subitem.product_image, price: subitem.product_price))
                myproducts.append(MyProducts(productId: subitem.id_product))
                }
            }
            }}
     
        CreateGroceryAccountService.instance.createGroceryAccount(model: ClientModel(name: groceryname, email: email, password: pass, withImage: 1, profileImage: str_profileImg, latitude: latitude, longitude: longitude, phone: phone, deviceToken: "", hoursofwork: availablehours, myproducts: myproducts)) { (success) in
            if success {
               
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "homeVC") as! ClientHomeController
                self.navigationController?.pushViewController(newViewController, animated: true)
            } else {
                // this user name is used befor please use another one
            }
        }
        
        
    }
    
    @objc func getCategories(_ notification: Notification) {
        if let myDict = notification.object as? [DepartmentProductCategory] {
            for item in myDict {
                
                for subitem in item.sub_product {
                arrOfSubCategories.append(SubProductModel(id: subitem.id_product, title: subitem.product_title, img: subitem.product_image, price: subitem.product_price))
                }
                
                arrOfCategories.append(DepartmentProductCategory(id_categories: item.id_categories, name_categories: item.name_categories, image_categories: item.image_categories, expanded: false, sub_product: arrOfSubCategories))
            
                arrOfSubCategories.removeAll()
            }
        }
        productsTableView.reloadData()
    }
   
}

extension AllDepartmentProductsVC : UITableViewDelegate , UITableViewDataSource  , BEMCheckBoxDelegate {
    
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView(frame: CGRect(x: 0, y: 0, width: productsTableView.frame.size.width, height: 44))
        header.delegate = self
        header.secIndex = section
        header.btn.setTitle(arrOfCategories[section].name_categories, for: .normal)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrOfCategories[section].expanded {
            return arrOfCategories[section].sub_product.count
        } else {
      return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells") as? ExpandableViewCell
        cell?.title.text = arrOfCategories[indexPath.section].sub_product[indexPath.row].product_title
        cell?.chkbox.delegate = self
        cell?.chkbox.tag = indexPath.row
        cell?.chkbox.addTarget(self, action: #selector(getSelectedItem(sender:)), for: .touchUpInside)
        cell?.img.sd_setImage(with: URL(string: Images_Url + arrOfCategories[indexPath.section].sub_product[indexPath.row].product_image)) { (image, error, cache, urls) in
            if (error != nil) {
                cell?.img.image = UIImage(named: "bg")
            } else {
                cell?.img.image = image
            }
        }
        return cell!
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        // do stuff here
        print("sdasdafa  \(checkBox.tag)")
        
        if checkBox.isEnabled {
            //creat array
            //append sub category item
            cellSelected = checkBox.tag
            print("cell selected item : \(cellSelected)")
        } else if checkBox.isEnabled == false {
            //remove sub category item from array
        }
    }
    
    @objc func getSelectedItem(sender:BEMCheckBox){
        
    }
    
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
     return arrOfCategories.count
    }
    
}

extension AllDepartmentProductsVC : HeaderDelegate {
    
    func cellHeader(idx: Int) {
        arrOfCategories[idx].expanded = !arrOfCategories[idx].expanded
        productsTableView.reloadSections([idx], with: .automatic)
        headerSelected = idx
        print("header selected item : \(headerSelected)")
    }
}
