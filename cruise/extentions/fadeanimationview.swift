//
//  fadeanimationview.swift
//  cruise
//
//  Created by ahmed abdelhameed on 11/22/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import Foundation

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
