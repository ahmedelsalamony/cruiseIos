//
//  ClientAccountRegisterVC.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/13/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit
import CoreData
import Photos

class ClientAccountRegisterVC: UIViewController , UINavigationControllerDelegate , UIImagePickerControllerDelegate {

    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var txtphone: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var txtretypepassword: UITextField!
    @IBOutlet weak var profilePic: CirculeImage!
    
    //vars
    var str_profilePic : String = ""
    var withImage : Int = 1
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
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bg-1")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        self.title = "create account"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
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
    
    //Final step put this Delegate
    @objc func imagePickerController(_ picker: UIImagePickerController,
                                     didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Error: \(info)")
            return
        }
        profilePic.image = selectedImage
        let imageData:Data = selectedImage.pngData()!
        str_profilePic = imageData.base64EncodedString()
        dismiss(animated: true, completion: nil)
    }
    
    func setupImgPicker(){
        imgpickercontroller.sourceType = .photoLibrary
        self.present(imgpickercontroller,animated: true,completion: nil)
    }
    
    
    @IBAction func backToHome(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "homeVC") as! ClientHomeController
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    @IBAction func registerationBtnClicked(_ sender: Any) {
        
        let latitude = UserDefaults.standard.string(forKey: "latitude") ?? ""
        let longitude = UserDefaults.standard.string(forKey: "longitude") ?? ""
        
        let clientobj = ClientModel(name: txtname.text!, email: txtemail.text!, password: txtpassword.text!, withImage: withImage, profileImage: str_profilePic, latitude: latitude, longitude: longitude, phone: txtphone.text!, deviceToken: "testtoken")
        
        
        CreateClientAccountService.instance.createAccount(model: clientobj) { (success) in
            if success {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "homeVC") as! ClientHomeController
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
        }
    }
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        
    }
    
    
    @IBAction func addProfilePic(_ sender: Any) {
        self.withImage = 2
        setupImgPicker()
    }
    
}
