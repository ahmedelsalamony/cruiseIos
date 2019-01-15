//
//  SearchVC.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/24/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


class SearchVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource ,UITextFieldDelegate  {
    
    //outlets
    @IBOutlet weak var searchResultCV: UICollectionView!
    @IBOutlet weak var txtSeachkey: UITextField!
    
    //variables
    var arrOfSearchResults = [SearchModel]()
    var arrofSearchResultToSuperDetails = [SubSuperModel]()
    let layout: UICollectionViewFlowLayout  = UICollectionViewFlowLayout()
    
    func setupNavigationBarStyle(){
        //change navigation color and tab bar text color
//        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 122, blue: 255 ,alpha : 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarStyle()
        self.title = "Cruise"
        self.searchResultCV.register(UINib(nibName: "SuperDetailsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SuperMarketDetailsCell")
        searchResultCV.delegate = self
        searchResultCV.dataSource = self
        txtSeachkey.delegate = self
        displayOfCollectionView()
    }
    
    func displayOfCollectionView() {
        self.searchResultCV!.collectionViewLayout = layout
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) // as pading
        layout.minimumInteritemSpacing = 5 // space between items in collectionview
        layout.itemSize =  CGSize(width: (self.searchResultCV.frame.size.width - 20) / 2, height:
            ((self.searchResultCV.frame.size.height ) / 2) - 20 )
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        print("done click ")
        guard let searchkey = txtSeachkey.text , !searchkey.isEmpty else {return}
        SearchService.instance.getSearchResult(searchkey: searchkey) { (success) in
            if success {
                
                print("in search vc :: ")
                
                NotificationCenter.default.addObserver(forName: Notification.Name.searchResultNotification, object: nil, queue: OperationQueue.main) { (Notification) in
                    let searchResultArr =  Notification.object as? [SearchModel]
                    for item in searchResultArr! {
                        self.arrOfSearchResults.append(SearchModel(product_id: item.product_id ?? "" , is_admin: item.is_admin ?? "", main_department: item.main_department ?? "", market_id: item.market_id ?? "", product_cost: item.product_cost ?? "", categories_name: item.categories_name ?? "", id_categories: item.id_categories ?? "", product_name: item.product_name ?? "", product_image: item.product_image ?? "", product_content: item.product_content ?? "", market_name: item.market_name ?? "", market_phone: item.market_phone ?? "", market_google_lat: item.market_google_lat ?? "", market_google_long: item.market_google_long ?? "", market_city: item.market_city ?? "", market_photo: item.market_photo ?? "", delivery_cost: item.delivery_cost ?? ""))
                        
                        self.arrofSearchResultToSuperDetails.append(SubSuperModel(id_product: item.product_id ?? "", product_title: item.product_name ?? "", product_image: item.product_image ?? "", product_price: item.product_cost ?? ""))
                        
                        self.searchResultCV.reloadData()
                    }
                }
            } else {
                print("enter seach key valid")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOfSearchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuperMarketDetailsCell", for: indexPath) as! SuperDetailsCollectionCell
        cell.setupSuperDetailsData(model: arrofSearchResultToSuperDetails[indexPath.row],
                                   category_id: arrOfSearchResults[indexPath.row].id_categories!
            ,market_id : arrOfSearchResults[indexPath.row].market_id!, deliveryCost: arrOfSearchResults[indexPath.row].delivery_cost!, marketname: arrOfSearchResults[indexPath.row].market_name! )
        return cell
    }
    
}
