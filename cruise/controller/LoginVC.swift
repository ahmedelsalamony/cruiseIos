//
//  LoginVC.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/22/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var txtusername: UITextFieldX!
    @IBOutlet weak var txtpassword: UITextFieldX!
    
    func setupNavigationBarStyle(){
        //change navigation color and tab bar text color
//        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 122, blue: 255 ,alpha : 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarStyle()
        // Do any additional setup after loading the view.
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bg-1")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        self.title = "login"
    
    }
    
    
    @IBAction func forgetpasswordClicked(_ sender: Any) {
    }
    
    @IBAction func loginbtnClicked(_ sender: Any) {
        
        if !(txtusername.text?.isEmpty)! && !(txtpassword.text?.isEmpty)! {
            LoginServices.instance.login(username: txtusername.text!, password: txtpassword.text!) { (success) in
                if success {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "homeVC") as! ClientHomeController
                    self.navigationController?.pushViewController(newViewController, animated: true)
                  
                    //call update token to get saved notification from sever
                    LoginServices.instance.updateTokenId(userId: UserDefaults.standard.value(forKey: "userId") as! String, completion: { (Bool) in
                        
                    })
                
                }else {
                    self.invalideAlert()
                }
            }
        } else {
            self.invalideAlert()
        }
    }
    
    
    func invalideAlert(){
        // create the alert
        let alert = UIAlertController(title: "Cruise", message: "من فضلك تاكد من اسم المستخدم وكلمة المرور", preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
