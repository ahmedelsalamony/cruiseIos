//
//  CardViewStyle.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/17/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import Foundation

@IBDesignable
class CurvedImageStyle: UIImageView {
    
    
    @IBInspectable var cornerRadius: CGFloat = 4 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        
        didSet{
            
            self.layer.borderWidth = borderWidth
        }
    }
    
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        
        didSet {
            
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
}
