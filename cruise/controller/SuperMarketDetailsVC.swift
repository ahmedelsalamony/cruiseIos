//
//  CategoriesCollectionView.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/17/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit

class SuperMarketDetailsVC: UIViewController   , UICollectionViewDelegate , UICollectionViewDataSource {

    @IBOutlet weak var detailscollectionview: UICollectionView!
    
    //variables
    var arrOfSubCategories = [SubSuperModel]()
    var generalMarketModel : MarketModel!
    let layout: UICollectionViewFlowLayout  = UICollectionViewFlowLayout()
   
    func setupNavigationBarStyle(){
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarStyle()
        self.title = "Cruise"
        self.detailscollectionview.reloadData()
        self.detailscollectionview.register(UINib(nibName: "SuperDetailsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SuperMarketDetailsCell")
        detailscollectionview.delegate = self
        detailscollectionview.dataSource = self
        displayOfCollectionView()
    }
    
    func displayOfCollectionView() {
        self.detailscollectionview!.collectionViewLayout = layout
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) // as pading
        layout.minimumInteritemSpacing = 5 // space between items in collectionview
        layout.itemSize =  CGSize(width: (self.detailscollectionview.frame.size.width - 20) / 2, height:
            ((self.detailscollectionview.frame.size.height ) / 2) - 20 )
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOfSubCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuperMarketDetailsCell", for: indexPath) as! SuperDetailsCollectionCell
    
        UserDefaults.standard.set("Super", forKey: "MiniOrSuper")
        cell.setupSuperDetailsData(model: arrOfSubCategories[indexPath.row],
                                   category_id: generalMarketModel.id_categories! ,market_id : generalMarketModel.market_id!, deliveryCost : self.generalMarketModel.delivery_cost!,marketname: self.generalMarketModel.market_name! )
        
        cell.setupDataToProducts(producttitle: arrOfSubCategories[indexPath.row].product_title!, productprice: arrOfSubCategories[indexPath.row].product_price!, productid: arrOfSubCategories[indexPath.row].id_product!, productimage: arrOfSubCategories[indexPath.row].product_image!, category_id: generalMarketModel.id_categories!, market_id: generalMarketModel.market_id!, deliveryCost: generalMarketModel.delivery_cost!, marketname: generalMarketModel.market_name!)
        
        cell.delegate = self
        return cell
    }
}

// add to cart using the following extention & delegate
extension SuperMarketDetailsVC : AddToCartProtocol {
    func addToCartDelegate() {
    }
}
