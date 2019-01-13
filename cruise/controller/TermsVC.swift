//
//  TermsVC.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/13/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import UIKit

class TermsVC: UIViewController {

    @IBOutlet weak var lblcontent: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginServices.instance.appTerms { (success) in
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(getTerms), name: Notification.Name.TermsNotification , object: nil)
      
    }
    
    @objc func getTerms(_ notification: Notification){
     
        let terms = notification.object as? String
        lblcontent.text = terms
    }
    
    
    

}
