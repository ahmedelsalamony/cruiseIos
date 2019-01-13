//
//  CustomRoundedBtn.swift
//  tasktyios
//
//  Created by ahmed abdelhameed on 10/12/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import Foundation

@IBDesignable class CustomRoundedBtn : UIButton {
    
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
    //to change color image from storyboard
    @IBInspectable var backgroundImageColor: UIColor = UIColor.init(red: 0, green: 122/255.0, blue: 255/255.0, alpha: 1) {
        didSet {
            refreshColor(color: backgroundImageColor)
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
        refreshColor(color: backgroundImageColor)
    }
    //update corber radius
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }
    //this func return colored img 1*1 pixel with color to fix animation behavior
    func createImage(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), true, 0.0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        return image
    }
    func refreshColor(color: UIColor) {
        let image = createImage(color: color)
        setBackgroundImage(image, for: UIControl.State.normal)
        clipsToBounds = true
    }
    
    func refreshBorder(value : CGFloat){
        layer.borderWidth = border
        layer.borderColor  = UIColor.lightGray.cgColor
    }
    
}
