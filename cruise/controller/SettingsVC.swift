//
//  SettingsVC.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/12/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet var SettingsViewContainer: UIView!
    @IBOutlet weak var createClientAccountImg: UIImageView!
    @IBOutlet weak var createGrocery: UIImageView!
    @IBOutlet weak var createDriverAccountImg: UIImageView!
    @IBOutlet weak var createClientAccountlbl: UILabel!
    @IBOutlet weak var createGroceryAccountlbl: UILabel!
    @IBOutlet weak var createDriverAccountlbl: UILabel!
    
    func setupNavigationBarStyle(){
        //change navigation color and tab bar text color
//        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 122, blue: 255 ,alpha : 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarStyle()
        self.setupCardView()
        self.title = "Cruise"
        
        let tapGestureRecognizer_client = UITapGestureRecognizer(target: self, action: #selector(imageTappedClient))
        createClientAccountImg.isUserInteractionEnabled = true
        createClientAccountImg.addGestureRecognizer(tapGestureRecognizer_client)
        createClientAccountlbl.isUserInteractionEnabled = true
        createClientAccountlbl.addGestureRecognizer(tapGestureRecognizer_client)
        
        let tapGestureRecognizer_grocery = UITapGestureRecognizer(target: self, action: #selector(imageTappedGrocery))
        createGrocery.isUserInteractionEnabled = true
        createGrocery.addGestureRecognizer(tapGestureRecognizer_grocery)
        createGroceryAccountlbl.isUserInteractionEnabled = true
        createGroceryAccountlbl.addGestureRecognizer(tapGestureRecognizer_grocery)
        
        
        let tapGestureRecognizer_driver = UITapGestureRecognizer(target: self, action: #selector(imageTappedDriver))
        createDriverAccountImg.isUserInteractionEnabled = true
        createDriverAccountImg.addGestureRecognizer(tapGestureRecognizer_driver)
        createDriverAccountlbl.isUserInteractionEnabled = true
        createDriverAccountlbl.addGestureRecognizer(tapGestureRecognizer_driver)

    }
    
   @objc func imageTappedClient()
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ClientAccountRegisterVC") as! ClientAccountRegisterVC
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func imageTappedGrocery()
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "grocery") as! GroceryAccountRegisterVC
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func imageTappedDriver()
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DriverVC") as! DriverAccountRegisterVC
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    func setupCardView(){
        SettingsViewContainer.layer.cornerRadius = 12.0
        SettingsViewContainer.layer.masksToBounds = false
        SettingsViewContainer.layer.shadowColor = UIColor.gray.cgColor
        SettingsViewContainer.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        SettingsViewContainer.layer.shadowOpacity = 0.8
        
    }
    
}
