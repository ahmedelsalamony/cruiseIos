//
//  CartVC.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/23/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit
import CoreData



class CartVC: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate {
    
    //outlets
    @IBOutlet weak var cartitemCV: UICollectionView!
    
    //vars
    var arrOfCartItems = [SubSuperModel]()
    var generalMarketIfo  = [MarketModel]()
    let layout: UICollectionViewFlowLayout  = UICollectionViewFlowLayout()
    var cartitem : MarketModel!
    var cartItemModel : SubSuperModel!
    var arrOfProducts = [Cart]()
    var productitem : CartModel!
    var selected_item : Int = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Cruise"
        self.cartitemCV.reloadData()
    }
    
    func setupNavigationBarStyle(){
        //change navigation color and tab bar text color
//        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 122, blue: 255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarStyle()
        getCartProducts()
        
        
        self.cartitemCV.register(UINib(nibName: "CartCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cartcell")
        self.cartitemCV.reloadData()
        cartitemCV.delegate = self
        cartitemCV.dataSource = self
        displayOfCollectionView()
    }
    
    
    func displayOfCollectionView() {
        self.cartitemCV!.collectionViewLayout = layout
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) // as pading
        layout.minimumInteritemSpacing = 5 // space between items in collectionview
        layout.itemSize =  CGSize(width: (self.cartitemCV.frame.size.width - 20) / 1, height:
            ((self.cartitemCV.frame.size.height ) / 3 ) - 20 )
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOfProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartcell", for: indexPath) as! CartCollectionCell
        cell.setupDateToCart(selected_producr_id : arrOfProducts[indexPath.row].product_id! ,selectedindex : indexPath.row ,model: arrOfProducts[indexPath.row])
        cell.delegate = self
        cell.cardview.layer.cornerRadius = 3
        cell.cardview.layer.masksToBounds = false
        cell.cardview.layer.shadowColor = UIColor.lightGray.cgColor
        cell.cardview.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.cardview.layer.shadowOpacity = 0.8
        return cell
    }
    
    
    
    @IBAction func btnCheckout(_ sender: Any) {
//        //retreive values in core data
//        let fetchRequest : NSFetchRequest<Cart> = Cart.fetchRequest()
//        do {
//            let arrofProducts = try PersistanceManager.context.fetch(fetchRequest)
//            self.arrOfProducts = arrofProducts
//            self.cartitemCV.reloadData()
//        }catch {
//        }
//        var arrofobjects = [[String:Any]]()
//
//        for item in arrOfProducts {
//
//            arrofobjects.append(["user_id":"1","id_product":item.product_id as Any,"product_amount":item.product_amount
//                ,"product_cost":item.product_price,"id_categories":item.id_category
//                ,"user_google_lat":"30.561319",
//                 "user_google_long":"31.006508","user_address":""])
//        }
//
//        AddSuperOrder.instance.sendSuperOrder(params: arrofobjects) { (success) in
//            print("send order successfully")
//            //delete value in core date
//            self.deleteAllData("Cart")
//
//        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        navigationController?.pushViewController(newViewController, animated: true)
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
        self.arrOfProducts.removeAll()
        self.cartitemCV.reloadData()
    }
    
    func getCartProducts(){
        
        //retreive values in core data
        let fetchRequest : NSFetchRequest<Cart> = Cart.fetchRequest()
        do {
            let arrofProducts = try PersistanceManager.context.fetch(fetchRequest)
            self.arrOfProducts = arrofProducts
            self.cartitemCV.reloadData()
        }catch {
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selected_item = indexPath.row
    }
}

extension CartVC : deleteCartItemDelegate {
    func deleteDelegate(cell: CartCollectionCell) {
        self.arrOfProducts.remove(at: selected_item)
        cartitemCV.reloadData()
    }
}
