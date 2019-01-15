//
//  SelectCityAreaVC.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/15/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit
import BEMCheckBox

class SelectCityAreaVC: UIViewController {

    @IBOutlet weak var viewcontainer: UIView!
    @IBOutlet weak var selectlbl: UILabel!
    @IBOutlet weak var firstlbl: UILabel!
    @IBOutlet weak var secondlbl: UILabel!
    @IBOutlet weak var firstchb: BEMCheckBox!
    @IBOutlet weak var secondchb: BEMCheckBox!
    var selectcityarea = ""
    var arrOfCities = [CityAreaModel]()
    
    @IBAction func firstclicked(_ sender: Any) {
        self.secondchb.on = false
        let firstcityobj = firstlbl.text
        if selectcityarea == "identifier_city"{
            NotificationCenter.default.post(name: Notification.Name.ValueOfFirstCityNotification, object: firstcityobj)
        } else if selectcityarea == "identifier_area" {
            NotificationCenter.default.post(name: Notification.Name.ValueOfFirstAreaNotification, object: firstcityobj)
        }
    }
    
    
    
    
    @IBAction func secondclicked(_ sender: Any) {
       self.firstchb.on = false
        let secondcityobj = secondlbl.text
        if selectcityarea == "identifier_city"{
            NotificationCenter.default.post(name: Notification.Name.ValueOfSecondCityNotification, object: secondcityobj)
        } else if selectcityarea == "identifier_area" {
            NotificationCenter.default.post(name: Notification.Name.ValueOfSecondAreaNotification, object: secondcityobj)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCardView()
        
        AddressServices.instance.getCities { (success) in
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(getCityArea), name: Notification.Name.CityAreaNotification , object: nil)
        
        
        if selectcityarea == "identifier_city" {
            selectlbl.text = "select city"
            firstlbl.text = "مدينة الرياض"
            secondlbl.text = "مدينة حائل"
        }else if selectcityarea == "identifier_area"{
            selectlbl.text = "select neighbourhood"
            firstlbl.text = "الحى الاول "
            secondlbl.text = "الحى الثانى"        }
    }
    
    @objc func getCityArea(_ notification : Notification){
        arrOfCities.removeAll()
        if let myDict = notification.object as? [CityAreaModel] {
            for item in myDict {
                arrOfCities.append(CityAreaModel(cityid: item.cityid! , citytitle: item.citytitle!, arrOfAreas: item.arrOfAreas!))
            }
        }}
    
    @IBAction func doneBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupCardView() {
        viewcontainer.layer.cornerRadius = 6
        viewcontainer.layer.masksToBounds = false
        viewcontainer.layer.shadowColor = UIColor.lightGray.cgColor
        viewcontainer.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        viewcontainer.layer.shadowOpacity = 0.8
    }
    

  
}
