//
//  DriverAccountRegisterVC.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/13/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit
import Photos

class DriverAccountRegisterVC: UIViewController , UINavigationControllerDelegate , UIImagePickerControllerDelegate  {
   
    @IBOutlet weak var txtdrivername: UITextFieldX!
    @IBOutlet weak var txtdriverphone: UITextFieldX!
    @IBOutlet weak var txtemail: UITextFieldX!
    @IBOutlet weak var txtpassword: UITextFieldX!
    @IBOutlet weak var txtconfirmpassword: UITextFieldX!
    @IBOutlet weak var txtcity: UIButtonX!
    @IBOutlet weak var txtarea: UIButtonX!
    @IBOutlet weak var profilePicImg: CirculeImage!
    
    //vars
    let selectcity = SelectCityAreaVC()
    var manualTag = 0
    var str_profileImg = ""
    var str_licenseImg = ""
    var str_carImg = ""
    var str_residenceImg = ""
    let imgpickercontroller = UIImagePickerController()
    
    func setupNavigationBarStyle(){
        //change navigation color and tab bar text color
//        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 122, blue: 255 ,alpha : 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarStyle()
        checkPermission()
        imgpickercontroller.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(getSelectedCity), name: Notification.Name.ValueOfFirstCityNotification , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getSelectedCity), name: Notification.Name.ValueOfSecondCityNotification , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getSelectedArea), name: Notification.Name.ValueOfFirstAreaNotification , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getSelectedArea), name: Notification.Name.ValueOfSecondAreaNotification , object: nil)
        
        
        
    }
    

    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }
    
    @objc func getSelectedCity(_ notification: Notification) {
        if let myDict = notification.object as? String {
            print("mydict lkfsdjlfs is \(myDict)")
            txtcity.setTitle(myDict, for: .normal)
        }
    }
    
    @objc func getSelectedArea(_ notification: Notification) {
        if let myDict = notification.object as? String {
            print("mydict lkfsdjlfs is \(myDict)")
            txtarea.setTitle(myDict, for: .normal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if txtcity.isTouchInside {
            if segue.identifier == "identifier_city" {
                let select = segue.destination as! SelectCityAreaVC
               select.selectcityarea = "identifier_city"
               
            }
        }else if txtarea.isTouchInside {
            if segue.identifier == "identifier_area" {
                let select = segue.destination as! SelectCityAreaVC
                select.selectcityarea = "identifier_area"
               
            }
        }
    }
   
    //Final step put this Delegate
    @objc func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Error: \(info)")
            return
        }
        if manualTag == 1 {
            profilePicImg.image = selectedImage
            
            let imageData:Data = selectedImage.pngData()!
            str_profileImg = imageData.base64EncodedString()
            
        }else if manualTag == 2 {
            let imageData:Data = selectedImage.pngData()!
            str_licenseImg = imageData.base64EncodedString()
            
        }else if manualTag == 3 {
            let imageData:Data = selectedImage.pngData()!
            str_residenceImg = imageData.base64EncodedString()
            
        }else if manualTag == 4 {
            let imageData:Data = selectedImage.pngData()!
            str_carImg = imageData.base64EncodedString()
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func selectCity(_ sender: Any) {
      
    }
    
    @IBAction func addProfilePic(_ sender: Any) {
        manualTag = 1
        setupImgPicker()
    }
    
    @IBAction func selectNeighbourhood(_ sender: Any) {
    
    }
    
    @IBAction func selectLicenseImg(_ sender: Any) {
        manualTag = 2
        setupImgPicker()
    }
    
    @IBAction func selectResidenceImg(_ sender: Any) {
        manualTag = 3
        setupImgPicker()
    }
    
    @IBAction func selectCarFormImg(_ sender: Any) {
       manualTag = 4
       setupImgPicker()
    }
    
    
    func setupImgPicker(){
        imgpickercontroller.sourceType = .photoLibrary
        self.present(imgpickercontroller,animated: true,completion: nil)
    }
    
    @IBAction func registerDriver(_ sender: Any) {
        
        let latitude = UserDefaults.standard.string(forKey: "latitude") ?? ""
        let longitude = UserDefaults.standard.string(forKey: "longitude") ?? ""
        
        CreateDriverAccountService.instance.createAccount(model: ClientModel(name: txtdrivername.text!, email: txtemail.text!, password: txtpassword.text!, profileImage: str_profileImg, latitude: latitude, longitude: longitude, phone: txtdriverphone.text!, deviceToken: "", licence: str_licenseImg, car_photo: str_carImg, residence: str_residenceImg)) { (success) in
            if success {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "homeVC") as! ClientHomeController
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
        }
    }
    
}
