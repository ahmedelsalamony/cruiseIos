//
//  CategoryDetailsOfMiniDetails.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/23/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//
import UIKit

class CategoryDetailsOfMiniDetails: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
   
    
    @IBOutlet weak var categoryitemsCV: UICollectionView!
    
    //vars
    var arrOfMiniMarketProducts = [MiniMarketProducts]()
    let layout: UICollectionViewFlowLayout  = UICollectionViewFlowLayout()
    var generalMarketModel : MarketModel!
    var miniMarketModel : MiniMarketModel!
    var categoryId = UserDefaults.standard.value(forKey: "categoryId") as! String
    
    func setupNavigationBarStyle(){
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarStyle()
        self.title = "Cruise"
        self.categoryitemsCV.reloadData()
        
        self.categoryitemsCV.register(UINib(nibName: "SuperDetailsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SuperMarketDetailsCell")
        
        categoryitemsCV.delegate = self
        categoryitemsCV.dataSource = self
        
        displayOfCollectionView()
    }
    
    func displayOfCollectionView() {
        self.categoryitemsCV!.collectionViewLayout = layout
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) // as pading
        layout.minimumInteritemSpacing = 5 // space between items in collectionview
        layout.itemSize =  CGSize(width: (self.categoryitemsCV.frame.size.width - 20) / 2, height:
            ((self.categoryitemsCV.frame.size.height ) / 2) - 20 )
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOfMiniMarketProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuperMarketDetailsCell", for: indexPath) as! SuperDetailsCollectionCell
        cell.setupDataToProducts(producttitle: arrOfMiniMarketProducts[indexPath.row].product_title!, productprice: arrOfMiniMarketProducts[indexPath.row].product_price!, productid: arrOfMiniMarketProducts[indexPath.row].id_product!, productimage: arrOfMiniMarketProducts[indexPath.row].product_image!, category_id: categoryId, market_id: miniMarketModel.market_id!, deliveryCost: miniMarketModel.delivery_cost!  , marketname: miniMarketModel.market_name!)
        
        UserDefaults.standard.set("Mini", forKey: "MiniOrSuper")
        return cell
    }

}
