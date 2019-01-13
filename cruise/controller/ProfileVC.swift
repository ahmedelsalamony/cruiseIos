//
//  ProfileVC.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/13/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var ivprofile: UIImageView!
    @IBOutlet weak var lblphone: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblpass: UILabel!
    
    //vars
    var userPhoto = ""
    var userPhone = ""
    var userName = ""
    
    
    func setupNavigationBarStyle(){
        navigationItem.title = "Profile"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        ivprofile.layer.cornerRadius = ivprofile.frame.height/2
        ivprofile.clipsToBounds = true
        
        userPhoto = UserDefaults.standard.string(forKey: "userPhoto") ?? ""
        userPhone = UserDefaults.standard.string(forKey: "userPhone") ?? ""
        userName = UserDefaults.standard.string(forKey: "userName") ?? ""
        
        lblphone.text = userPhone
        lblname.text = userName
        ivprofile.sd_setImage(with: URL(string: Images_Url + userPhoto)) { (image, error, cache, urls) in
            if (error != nil) {
                self.ivprofile.image = UIImage(named: "bg")
            } else {
                self.ivprofile.image = image
            }
        }
    }


}
