//
//  CityAreaModel.swift
//  cruise
//
//  Created by ahmed abdelhameed on 1/16/19.
//  Copyright © 2019 ahmed abdelhameed. All rights reserved.
//

import Foundation

struct CityAreaModel{
    
    var cityid : String?
    var citytitle : String?
    var arrOfAreas : [AreasModel]?
    
    init(cityid : String , citytitle : String , arrOfAreas : [AreasModel]) {
        self.cityid = cityid
        self.citytitle = citytitle
        self.arrOfAreas = arrOfAreas
    }
}

struct AreasModel {
    
    var areaid : String?
    var areatitle : String?

    init(areaid : String , areatitle : String) {
        self.areaid = areaid
        self.areatitle = areatitle
    }

}
