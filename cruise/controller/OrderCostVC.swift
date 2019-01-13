//
//  OrderCostVC.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/23/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit
import CoreData

class OrderCostVC: UIViewController {
    
    @IBOutlet weak var lbltotalcost: UILabel!
    @IBOutlet weak var lblsubtotal: UILabel!
    @IBOutlet weak var lbldeliverycost: UILabel!
    @IBOutlet weak var ordercostviewcontainer: UIView!
    @IBOutlet weak var genaralmarketviewcontainer: UIView!
    @IBOutlet weak var marketid: UILabel!
    @IBOutlet weak var marketname: UILabel!
    
    //vars
    var arrOfProducts = [Cart]()
    var arrOfCartItems = [SubSuperModel]()
    var cartItemModel : SubSuperModel!
    var cartitem : MarketModel!
    var generalMarketIfo  = [MarketModel]()
    var arrofobjects = [[String:Any]]()
    
    func setupNavigationBarStyle(){
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarStyle()
        setupCardView(view: ordercostviewcontainer)
        setupCardView(view: genaralmarketviewcontainer)
        
        let latitude = UserDefaults.standard.string(forKey: "latitude") ?? ""
        let longitude = UserDefaults.standard.string(forKey: "longitude") ?? ""
        
        //retreive values in core data
        let fetchRequest : NSFetchRequest<Cart> = Cart.fetchRequest()
        do {
            let arrofProducts = try PersistanceManager.context.fetch(fetchRequest)
            self.arrOfProducts = arrofProducts
        }catch {}
        for item in arrOfProducts {
            arrofobjects.append(["user_id":"1","id_product":item.product_id as Any,
                                 "product_amount":item.product_amount
                ,"product_cost":item.product_price,"id_categories":item.id_category as Any,
            "user_google_lat":latitude,"user_google_long":longitude,"user_address":""])
        }
        let deliveryCost  = UserDefaults.standard.value(forKey: "deliveryCost")
        var pricetest : Double = 0.0
        for item in arrOfProducts{
            pricetest = pricetest + Double(item.product_price)
        }
       
          lblsubtotal.text = String(pricetest) + "SAR"
          lbldeliverycost.text = "\(deliveryCost!) SAR"
          let valueOfTotalCost = deliveryCost as! Double + pricetest
          lbltotalcost.text = String(valueOfTotalCost) + "SAR"
        
        marketid.text = UserDefaults.standard.value(forKey: "marketId") as! String
        marketname.text = UserDefaults.standard.value(forKey: "marketName") as! String
        }
    
    
   
    @IBAction func btnsendorders(_ sender: Any){

        AddSuperOrder.instance.sendSuperOrder(params: arrofobjects) { (success) in
            print("send order successfully")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "homeVC") as! ClientHomeController
            self.navigationController?.pushViewController(newViewController, animated: true)
            //delete value in core date
            self.deleteAllData("Cart")
        }
    }

    func setupCardView(view:UIView){
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        view.layer.shadowOpacity = 0.8
    }
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try PersistanceManager.persistentContainer.viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                PersistanceManager.persistentContainer.viewContext.delete(objectData)
            }
            do {
                try PersistanceManager.persistentContainer.viewContext.save()
            } catch {}
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
      //  self.arrOfProducts.removeAll()
    }
}
