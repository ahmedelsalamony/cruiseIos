//
//  Cart+CoreDataProperties.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/8/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }
    @NSManaged public var product_id: String?
    @NSManaged public var product_name: String?
    @NSManaged public var product_amount: Int16
    @NSManaged public var product_price: Double
    @NSManaged public var product_image: String?
    @NSManaged public var id_category: String?
    @NSManaged public var market_id: String?

}
