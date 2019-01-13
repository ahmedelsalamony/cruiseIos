//
//  ExpandableHeaderView.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/14/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import UIKit

protocol ExpandableHeaderViewDelegate {
    func toggleSection(header : ExpandableHeaderView , section :Int) 
}

class ExpandableHeaderView: UITableViewHeaderFooterView {
    var delegate : ExpandableHeaderViewDelegate?
    var section : Int!


    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    @objc func selectHeaderAction(GestureRecognizer : UITapGestureRecognizer){
        let cell = GestureRecognizer.view as? ExpandableHeaderView
        delegate?.toggleSection(header: self, section: (cell?.section)!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customInit(title  : String , section :Int , delegate : ExpandableHeaderViewDelegate){
        self.delegate = delegate
        self.section = section
        self.textLabel!.text = title
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.textColor = UIColor.white
        self.contentView.backgroundColor = UIColor.lightGray
        
    }

}
