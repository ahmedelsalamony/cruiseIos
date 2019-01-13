//
//  SuperDetailsCollectionCell.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/20/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit
import CoreData

protocol AddToCartProtocol : class {
   func addToCartDelegate()
}

class SuperDetailsCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imgSubCategory: UIImageView!
    @IBOutlet weak var lblSubCategoryName: UILabel!
    @IBOutlet weak var lblSubCategoryPrice: UILabel!
    @IBOutlet weak var btnaddtocart: UIButtonX!
    @IBOutlet weak var lblproductcounter: CustomRoundedlbl!
    @IBOutlet weak var btnminusproduct: UIButton!
    @IBOutlet weak var lblpricelabel: UILabel!
    
    @IBOutlet weak var visualeffect: UIVisualEffectView!
    //variables
    var productPrice : Float = 0.0
    var _productName : String = ""
    var _productPrice : String = ""
    var _productId : String = ""
    var _productImg : String = ""
    var producttitle : String = ""
    var generalMarketModel : MarketModel!
    var arrOfCartItems = [SubSuperModel]()
    var cartItemModel : SubSuperModel!
    var category_id : String = ""
    var market_id : String = ""
    var deleveryCost : String = ""
    var marketname : String = ""
    weak var delegate : AddToCartProtocol?
    
    
    
    @IBAction func subCategoryBtnClicked(_ sender: Any) {
        lblpricelabel.fadeTransition(0.5)
        lblSubCategoryPrice.fadeTransition(0.5)
        if Int(lblproductcounter.text!)! >= 0 {
            lblproductcounter.text = String(Int(lblproductcounter.text!)! - 1)
            let priceaftercalc =  Float(lblSubCategoryPrice.text!)! - productPrice
            let s = NSString(format: "%.1f", priceaftercalc)
            lblSubCategoryPrice.text = s as String
            if Int(lblproductcounter.text!)! == 0 {
                btnaddtocart.isHidden = true
                btnminusproduct.isHidden = true
                let s = NSString(format: "%.1f", productPrice)
                lblSubCategoryPrice.text = s as String
            }
        }
        if (Int(lblproductcounter.text!)! > 0){
            visualeffect.isHidden = false
        }else {
            visualeffect.isHidden = true
        }
    }
    
    
    @IBAction func addCategoryBtnClicked(_ sender: Any) {
        btnminusproduct.isHidden = false
        btnaddtocart.isHidden = false
        lblpricelabel.fadeTransition(0.5)
        lblSubCategoryPrice.fadeTransition(0.5)
        lblproductcounter.text = String(Int(lblproductcounter.text!)! + 1)
        let priceaftercalc =  Float(lblproductcounter.text!)! * productPrice
        let s = NSString(format: "%.1f", priceaftercalc)
        lblSubCategoryPrice.text = s as String
        if (Int(lblproductcounter.text!)! > 0){
         visualeffect.isHidden = false
        }else {
            visualeffect.isHidden = true
        }
    }
    
    //add new item to cart from supermarket or minimarket 
    @IBAction func addProductsToCart(_ sender: Any) {
        delegate?.addToCartDelegate()
        let addtocart = Cart(context: PersistanceManager.context)
        if (UserDefaults.standard.value(forKey: "MiniOrSuper") as? String == "Super"){
            addtocart.product_id = cartItemModel.id_product
            addtocart.product_name = cartItemModel.product_title
            addtocart.product_image = cartItemModel.product_image
            addtocart.product_amount = Int16(lblproductcounter.text!)!
            addtocart.product_price = Double(lblSubCategoryPrice.text!)!
            addtocart.id_category = self.category_id
            addtocart.market_id = self.market_id
            UserDefaults.standard.set(Double(self.deleveryCost), forKey: "deliveryCost")
            UserDefaults.standard.set(self.marketname,forKey : "marketName")
            UserDefaults.standard.set(self.market_id,forKey : "marketId")
        } else if (UserDefaults.standard.value(forKey: "MiniOrSuper") as? String == "Mini"){
            //Mark
            addtocart.product_id = self._productId
            addtocart.product_name = self.producttitle
            addtocart.product_image = self._productImg
            addtocart.product_amount = Int16(lblproductcounter.text!)!
            addtocart.product_price = Double(lblSubCategoryPrice.text!)!
            addtocart.id_category = self.category_id
            addtocart.market_id = self.market_id
            UserDefaults.standard.set(Double(self.deleveryCost), forKey: "deliveryCost")
            UserDefaults.standard.set(self.marketname,forKey : "marketName")
            UserDefaults.standard.set(self.market_id,forKey : "marketId")
        }
        PersistanceManager.save()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        visualeffect.isHidden = true
        btnminusproduct.isHidden = true
        btnaddtocart.isHidden = true
        lblproductcounter.text = String(0)
        self.visualeffect.layer.cornerRadius = 15
        self.visualeffect.clipsToBounds = true
    }
    func setupSuperDetailsData(model : SubSuperModel , category_id : String , market_id : String ,deliveryCost : String , marketname : String ){
        self.deleveryCost = deliveryCost
        self.category_id = category_id
        self.marketname = marketname
        self.market_id = market_id
        cartItemModel = model
        arrOfCartItems.append(SubSuperModel(id_product: model.id_product!, product_title: model.product_title!, product_image: model.product_image!, product_price: model.product_price!))
        lblSubCategoryName.text = model.product_title
        lblSubCategoryPrice.text = model.product_price!
       
        productPrice = Float(model.product_price!)!
        
        imgSubCategory.sd_setImage(with: URL(string: Images_Url + model.product_image!)) { (image, error, cache, urls) in
            if (error != nil) {
                self.imgSubCategory.image = UIImage(named: "bg")
            } else {
                self.imgSubCategory.image = image
            }
        }
        _productName  = model.product_title!
        _productPrice = model.product_price!
        _productId    = model.id_product!
        _productImg   = model.product_image!
    }
    
    func setupDataToProducts(producttitle : String,productprice:String,productid:String,productimage:String, category_id : String , market_id : String ,deliveryCost : String , marketname : String ){
        
        self.deleveryCost = deliveryCost
        self.category_id = category_id
        self.marketname = marketname
        self.market_id = market_id
        self._productId = productid
        self.producttitle = producttitle
        self._productImg = productimage
       
        lblSubCategoryName.text = producttitle
        lblSubCategoryPrice.text = productprice
        productPrice = Float(productprice)!
        
        imgSubCategory.sd_setImage(with: URL(string: Images_Url + productimage)) { (image, error, cache, urls) in
            if (error != nil) {
                self.imgSubCategory.image = UIImage(named: "bg")
            } else {
                self.imgSubCategory.image = image
            }
        }
       
    }

}

