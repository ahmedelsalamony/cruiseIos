//
//  CartCollectionCell.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/23/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit
import CoreData

protocol deleteCartItemDelegate : class {
    func deleteDelegate(cell : CartCollectionCell)
}

class CartCollectionCell: UICollectionViewCell {

    //outlets
    @IBOutlet weak var cartitemimg: CurvedImageStyle!
    @IBOutlet weak var cartproductname: UILabel!
    @IBOutlet weak var cartamountlbl: UILabel!
    @IBOutlet weak var cartpricelbl: UILabel!
    @IBOutlet weak var cardview: UIView!
    
    //vars
    var selectedIndex : Int = 0
    weak var delegate : deleteCartItemDelegate?
    var cartvc = CartVC()
    var selected_producr_id = ""
    var productPrice : Float = 0.0
    
    @objc func getAmount(_ notification : Notification){
        if let amount = notification.object as? String {
            print("\(amount)")
            cartamountlbl.text = amount
        }
    }
    
    @IBAction func deleteItem(_ sender: Any) {
        delegate?.deleteDelegate(cell: self)
        //delete value in core date
        let fechrequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Cart")
        fechrequest.predicate = NSPredicate(format: "product_id = '\(Int16(selected_producr_id) ?? 0)'")
        do {
            let test = try PersistanceManager.persistentContainer.viewContext.fetch(fechrequest)
            let objectDelete = test[0] as! NSManagedObject
            PersistanceManager.persistentContainer.viewContext.delete(objectDelete)
            do {
                try PersistanceManager.persistentContainer.viewContext.save()
            } catch {}
        }catch{
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func addAmount(_ sender: Any) {
        
        cartamountlbl.text = String(Int(cartamountlbl.text!)! + 1)
        let priceaftercalc =  Float(cartamountlbl.text!)! * productPrice
        let s = NSString(format: "%.1f", priceaftercalc)
        cartpricelbl.text = s as String
        
        //update value in core data
        let fechrequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Cart")
        fechrequest.predicate = NSPredicate(format: "product_id = '\(Int16(selected_producr_id) ?? 0)'")
        do {
            let test = try PersistanceManager.persistentContainer.viewContext.fetch(fechrequest)
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(Int(cartamountlbl.text!)!, forKey: "product_amount")
            do {
                try PersistanceManager.persistentContainer.viewContext.save()
            } catch {}
            
        }catch{
        }
    }
    
    @IBAction func minusAmount(_ sender: Any) {
        
        if Int(cartamountlbl.text!)! > 1 {
        cartamountlbl.text = String(Int(cartamountlbl.text!)! - 1)
        let priceaftercalc =  Float(cartamountlbl.text!)! * productPrice
        let s = NSString(format: "%.1f", priceaftercalc)
        cartpricelbl.text = s as String
        } else {
            //delete item from core data and from collection view
            //delete value in core date
            let fechrequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Cart")
            fechrequest.predicate = NSPredicate(format: "product_id = '\(Int16(selected_producr_id) ?? 0)'")
            do {
                let test = try PersistanceManager.persistentContainer.viewContext.fetch(fechrequest)
                let objectDelete = test[0] as! NSManagedObject
                PersistanceManager.persistentContainer.viewContext.delete(objectDelete)
                do {
                    try PersistanceManager.persistentContainer.viewContext.save()
                } catch {}
            }catch{
            }
         delegate?.deleteDelegate(cell: self)
        }
        
    }
    
    func setupDateToCart(selected_producr_id : String ,selectedindex : Int,model : Cart){
        self.selected_producr_id = selected_producr_id
        self.selectedIndex = selectedindex
        self.productPrice = Float(model.product_price)
        
        cartamountlbl.text = String(model.product_amount)
        cartpricelbl.text = "\(model.product_price ?? 0.0)"
        cartproductname.text = model.product_name
        cartitemimg.sd_setImage(with: URL(string: Images_Url + model.product_image!)) { (image, error, cache, urls) in
            if (error != nil) {
                self.cartitemimg.image = UIImage(named: "bg")
            } else {
                self.cartitemimg.image = image
            }
        }
    }
    
}


