//
//  CustomRoundedView.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/24/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import Foundation


class CustomRoundedView : UIView {
//set default value for corner radius, use didSet to change this value from story board
@IBInspectable var cornerRadius: CGFloat = 15 {
    didSet {
        refreshCorners(value: cornerRadius)
    }
}
@IBInspectable var border : CGFloat = 2 {
    didSet {
        refreshBorder(value:border)
    }
}



override init(frame: CGRect) {
    super.init(frame: frame)
    shareInit()
}

required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    shareInit()
}

override func prepareForInterfaceBuilder() {
    shareInit()
}

func shareInit(){
    //logic here
    refreshCorners(value: cornerRadius)
   
}
//update corber radius
func refreshCorners(value: CGFloat) {
    layer.cornerRadius = value
}


func refreshBorder(value : CGFloat){
    layer.borderWidth = border
    layer.borderColor  = UIColor.white.cgColor
}

}
