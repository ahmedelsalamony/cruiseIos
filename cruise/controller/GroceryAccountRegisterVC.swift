//
//  GroceryAccountRegisterVC.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/13/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit
import Photos

class GroceryAccountRegisterVC: UIViewController , UINavigationControllerDelegate , UIImagePickerControllerDelegate {

    @IBOutlet weak var profilePic: CirculeImage!
    @IBOutlet weak var txtgroceryname: UITextFieldX!
    @IBOutlet weak var txtavailablehours: UITextFieldX!
    @IBOutlet weak var txtphonenumber: UITextFieldX!
    @IBOutlet weak var txtemail: UITextFieldX!
    @IBOutlet weak var txtpassword: UITextFieldX!
    @IBOutlet weak var txtconfirmpassword: UITextFieldX!
    
    //vars
    let imgpickercontroller = UIImagePickerController()
    var str_profileImg : String = ""
    var groceryname : String = ""
    var availablehours : String = ""
    var phone : String = ""
    var email : String = ""
    var pass : String = ""
    var confirmpass : String = ""
    
    
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
        
        self.title = "create grocery account"
        
    }
    
    @IBAction func addProfilePic(_ sender: Any) {
        setupImgPicker()
    }
    
    @IBAction func continueToRegister(_ sender: Any) {
        groceryname = txtgroceryname.text!
        availablehours = txtavailablehours.text!
        phone = txtphonenumber.text!
        email = txtemail.text!
        pass = txtpassword.text!
        confirmpass = txtconfirmpassword.text!
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AllDepartmentProductsVC
        vc.str_profileImg = self.str_profileImg
        vc.groceryname = self.groceryname
        vc.availablehours = self.availablehours
        vc.phone = self.phone
        vc.email = self.email
        vc.pass = self.pass
        vc.confirmpass = self.confirmpass
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
        str_profileImg = imageData.base64EncodedString()
        dismiss(animated: true, completion: nil)
    }
    
    func setupImgPicker(){
        imgpickercontroller.sourceType = .photoLibrary
        self.present(imgpickercontroller,animated: true,completion: nil)
    }
}
