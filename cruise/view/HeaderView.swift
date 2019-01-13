//
//  HeaderView.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/17/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit

protocol HeaderDelegate {
    func cellHeader(idx : Int)
}

class HeaderView: UIView {

    var secIndex : Int?
    var delegate : HeaderDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(btn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var btn : UIButton = {
        let btn = UIButton(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height))
        btn.backgroundColor = UIColor.lightGray
        btn.titleLabel?.textColor = UIColor.black
        btn.addTarget(self, action: #selector(onClickHeaderView), for: .touchUpInside)
        return btn
    }()

    @objc func onClickHeaderView(){
       
        if let idx = secIndex {
            delegate?.cellHeader(idx: idx)
            print("headre clicked \(idx)")
        }
       
    }
}
