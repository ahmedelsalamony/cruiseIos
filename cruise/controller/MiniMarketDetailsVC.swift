//
//  MiniMarketDetailsVC.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/22/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit

class MiniMarketDetailsVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
   
    @IBOutlet weak var minidetailsCV: UICollectionView!
     let layout: UICollectionViewFlowLayout  = UICollectionViewFlowLayout()
    
    var arrOfMiniMarketCategories = [MiniMarketCategories]()
    var miniMarketModel : MiniMarketModel!
    var generalMarketModel : MarketModel!

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
        // Do any additional setup after loading the view.
          self.minidetailsCV.register(UINib(nibName: "MiniDetailsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MiniDetailsCell")
        minidetailsCV.delegate = self
        minidetailsCV.dataSource = self
        minidetailsCV.reloadData()
        displayOfCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return  arrOfMiniMarketCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MiniDetailsCell", for: indexPath) as! MiniDetailsCollectionCell                                      
        cell.setupDataToCell(model: arrOfMiniMarketCategories[indexPath.row])
        return cell
    }
    
    func displayOfCollectionView() {
        self.minidetailsCV!.collectionViewLayout = layout
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) // as pading
        layout.minimumInteritemSpacing = 5 // space between items in collectionview
        layout.itemSize =  CGSize(width: (self.minidetailsCV.frame.size.width - 20) / 3, height:
            ((self.minidetailsCV.frame.size.height ) / 3) - 10 )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "categoryDetailsOfMiniDetails") as! CategoryDetailsOfMiniDetails
        newViewController.arrOfMiniMarketProducts = arrOfMiniMarketCategories[indexPath.row].minimarketproducts!
        newViewController.generalMarketModel = self.generalMarketModel
        newViewController.miniMarketModel  = self.miniMarketModel
        navigationController?.pushViewController(newViewController, animated: true)
    }

}
