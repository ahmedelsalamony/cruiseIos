//
//  CirculeImage.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/13/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import Foundation

@IBDesignable
class CirculeImage: UIImageView {
    
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
}
