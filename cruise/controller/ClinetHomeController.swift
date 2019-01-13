//
//  ViewController.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/13/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class ClientHomeController: UIViewController , CLLocationManagerDelegate , UICollectionViewDelegate , UICollectionViewDataSource {
    
    //  @IBOutlet var LoadingView: UIView!
    @IBOutlet weak var sidemenubtn: UIButton!
    @IBOutlet weak var categoriesSegmentControl: UISegmentedControl!
    @IBOutlet weak var searchlbl: UILabel!
    @IBOutlet weak var categoriescollection: UICollectionView!
    
    // variables
    let layout: UICollectionViewFlowLayout  = UICollectionViewFlowLayout()
    var arrOfSuperMarketCategories = [MarketModel]()
    var arrOfSuperDetails = [SubSuperModel]()
    var arrOfSubCategories = [SubCategoryModel]()
    var arrOfMiniMarket = [MiniMarketModel]()
    var arrOfMiniMarketCategories = [MiniMarketCategories]()
    var locationManager:CLLocationManager!
    var lat : String = ""
    var long : String = ""
    var latitude = UserDefaults.standard.string(forKey: "latitude") ?? ""
    var longitude = UserDefaults.standard.string(forKey: "longitude") ?? ""
    
    @IBOutlet weak var searhview: CustomRoundedView!
    
    func setupNavigationBarStyle(){
        //change navigation color and tab bar text color
//        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 122, blue: 255 ,alpha : 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarStyle()
        HomeServices.instance.getSuperMarketCategories { (result) in
            self.categoriescollection.reloadData()
        }
        
        HomeServices.instance.getMiniMarketCategories(lat: self.latitude, long: self.longitude) { (result) in
            self.categoriescollection.reloadData()
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        // following line used in set different size for each cell file "xib"
       self.categoriescollection!.collectionViewLayout = layout
        
        self.categoriescollection.register(UINib(nibName: "SuperMarketCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SuperMarketCell")
        self.categoriescollection.register(UINib(nibName: "MiniMarketCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MiniMarketCell")
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(getSuperMarketCategories), name: Notification.Name.superCategoriesNotification , object: nil)
        
          NotificationCenter.default.addObserver(self, selector: #selector(getMiniMarketCategories), name: Notification.Name.miniMarketNotification , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getSuperDetails), name: Notification.Name.subsuperCategoriesNotification , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getCategoriesOfMiniMarket), name: Notification.Name.categoriesOfMiniMarket , object: nil)
        
        categoriescollection.delegate = self
        categoriescollection.dataSource = self
        
        
    //custom action for searchview
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ClientHomeController.someAction(_:)))
    searhview.addGestureRecognizer(gesture)
    }
    
    // or for Swift 4
    @objc func someAction(_ sender:UITapGestureRecognizer){
        // do other task
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "searchvc") as! SearchVC
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func getSuperMarketCategories(_ notification: Notification) {
        arrOfSuperMarketCategories.removeAll()
        if let myDict = notification.object as? [MarketModel] {
            for item in myDict {
                arrOfSuperMarketCategories.append(MarketModel(market_id : item.market_id! ,market_name: item.market_name!, market_phone: item.market_phone!, market_google_lat: item.market_google_lat!, market_google_long: item.market_google_long!, market_city: item.market_city!, market_photo: item.market_photo!, delivery_cost: item.delivery_cost!, id_categories: item.id_categories!, name_categories: item.name_categories!, image_categories: item.image_categories! , superdetails : item.superdetails!,superOrMini : item.superOrMini))
            
            }
        }
    }
    
    @objc func getCategoriesOfMiniMarket(_ notification: Notification){
        if let categories = notification.object as? [MiniMarketCategories] {
            for category in categories {
                arrOfMiniMarketCategories.append(MiniMarketCategories(idcategories: category.id_categories!, namecategories: category.name_categories!, imagecategories: category.image_categories!, minimarketproducts: category.minimarketproducts!))
            }
        }
    }
    
    @objc func getMiniMarketCategories(_ notification : Notification){
        if let minimarketData = notification.object as? [MiniMarketModel]{
            for item in minimarketData {
            arrOfMiniMarket.append(MiniMarketModel(marketid: item.market_id!, marketname: item.market_name!, marketphone: item.market_phone!, marketgooglelat: item.market_google_lat!, marketgooglelong: item.market_google_long!, marketcity: item.market_city!, marketphoto: item.market_photo!, deliverycost: item.delivery_cost!, distance: item.distance!, minimarketcategories: item.minimarketcategories!))
            }
        }
    }
    
    @objc func getSuperDetails(_ notification: Notification) {
        if let myDict = notification.object as? [SubSuperModel] {
            for item in myDict {
               arrOfSuperDetails.append(SubSuperModel(id_product: item.id_product!, product_title: item.product_title!, product_image: item.product_image!, product_price: item.product_price!))
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
  
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if categoriesSegmentControl.selectedSegmentIndex == 0 {
            return arrOfSuperMarketCategories.count
        } else {
            return arrOfMiniMarket.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if categoriesSegmentControl.selectedSegmentIndex == 0 {
            let Supercell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuperMarketCell", for: indexPath) as! SuperMarketCollectionCell
            Supercell.setCategoryData(model: arrOfSuperMarketCategories[indexPath.row])
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) // as pading
            layout.minimumInteritemSpacing = 5 // space between items in collectionview
            layout.itemSize =  CGSize(width: (self.categoriescollection.frame.size.width - 20) / 3, height:
                ((self.categoriescollection.frame.size.height ) / 2) - 40 )
            return Supercell
        } else {
            let MiniMarketcell = collectionView.dequeueReusableCell(withReuseIdentifier: "MiniMarketCell", for: indexPath) as!
            MiniMarketCollectionCell
            MiniMarketcell.setMiniMarketData(model: arrOfMiniMarket[indexPath.row])
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) // as pading
            layout.minimumInteritemSpacing = 5 // space between items in collectionview
            layout.itemSize =  CGSize(width: (self.categoriescollection.frame.size.width - 20), height:
                ((self.categoriescollection.frame.size.height ) / 3)  )
            return MiniMarketcell
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if categoriesSegmentControl.selectedSegmentIndex == 0 {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "superDetailsVC") as! SuperMarketDetailsVC
            newViewController.arrOfSubCategories = arrOfSuperMarketCategories[indexPath.row].superdetails!
            newViewController.generalMarketModel = arrOfSuperMarketCategories[indexPath.row]
            
            
            navigationController?.pushViewController(newViewController, animated: true)
            
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MiniDetailsController") as! MiniMarketDetailsVC
            newViewController.arrOfMiniMarketCategories = arrOfMiniMarket[indexPath.row].minimarketcategories!
            newViewController.miniMarketModel = arrOfMiniMarket[indexPath.row]
            UserDefaults.standard.set(arrOfMiniMarketCategories[indexPath.row].id_categories, forKey: "categoryId")
            navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    
    
    
    @IBAction func segmentControlClicked(_ sender: Any) {
        if categoriesSegmentControl.selectedSegmentIndex == 0 {
            arrOfSuperMarketCategories.removeAll()
            HomeServices.instance.getSuperMarketCategories { (result) in
                self.categoriescollection.reloadData()
            }
            
        } else {
            arrOfMiniMarketCategories.removeAll()
            HomeServices.instance.getMiniMarketCategories(lat: self.latitude, long: self.longitude) { (result) in
                self.categoriescollection.reloadData()
            }
        }
    }

    
     //////////////////////// for get current location  ////////////////////////////////
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineMyCurrentLocation()
    }
    
   
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        // manager.stopUpdatingLocation()
        self.lat = String(userLocation.coordinate.latitude)
        self.long = String(userLocation.coordinate.longitude)
        UserDefaults.standard.set(self.lat, forKey: "latitude")
        UserDefaults.standard.set(self.long, forKey: "longitude")
        print("lat :: \(self.lat)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
}

