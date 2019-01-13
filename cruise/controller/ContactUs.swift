//
//  ContactUs.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/13/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import UIKit

class ContactUs: UIViewController {
    
    
    @IBOutlet weak var tvname: UITextField!
    @IBOutlet weak var tvemail: UITextField!
    @IBOutlet weak var tvphone: UITextField!
    @IBOutlet weak var tvsubject: UITextField!
    @IBOutlet weak var tvmsg: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        guard let name = tvname.text ,   !name.isEmpty  else {return}
        guard let email = tvemail.text , !email.isEmpty  else {return}
        guard let  phone = tvphone.text , !phone.isEmpty  else {return}
        guard let subject = tvsubject.text , !subject.isEmpty  else {return}
        guard let msg = tvmsg.text , !msg.isEmpty  else {return}
        
        LoginServices.instance.sendcWithContactUs(name: name, email: email, subject: subject, message: msg)
        { (success) in
            guard let window = UIApplication.shared.keyWindow else {return}
            let sb = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            window.rootViewController = sb
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
        }
    }
    
    
    
}
