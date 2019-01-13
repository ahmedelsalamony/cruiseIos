//
//  ResetPasswordVC.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/1/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    
    @IBOutlet weak var tvUserName: UITextFieldX!
    
    @IBOutlet weak var tvEmail: UITextFieldX!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func resetPasswordClicked(_ sender: Any) {
        guard let username = tvUserName.text , !username.isEmpty else {return}
        guard let email = tvEmail.text , !email.isEmpty else {return}
        LoginServices.instance.resetPassword(username: username , email: email ) { (Bool) in
            if Bool {
                
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(getResetPassResult), name: Notification.Name.resetPassResultNotification , object: nil)
    }
    
    @objc func getResetPassResult(_ notification: Notification){
        
        if let result = notification.object as? Int {
            if result == 1 {
                let alert = UIAlertController(title: "Reset Password", message: "تم ارسال لينك استعادة كلمة المرور بنجاح", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else if result == 0 {
                let alert = UIAlertController(title: "Reset Password", message: "من فضلك اعد المحاولة", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    
}
