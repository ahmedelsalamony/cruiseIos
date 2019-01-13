//
//  DataController.swift
//  cruise
//
//  Created by ahmed abdelhameed on 12/7/18.
//  Copyright © 2018 ahmed abdelhameed. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    
    let persistentContainer:NSPersistentContainer
    
    var viewContext:NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion : ( () -> Void)? = nil ){
        persistentContainer.loadPersistentStores { (storedescription , error ) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
}
