//
//  NSManagedObjectContext+LocalContext.swift
//  education_trata_swift
//
//  Created by 18577745 on 15.09.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    func saveWithBlockAndWait(_ updates: @escaping(_ localContext: NSManagedObjectContext) -> ()) {
        let localContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        localContext.parent = self
        localContext.automaticallyMergesChangesFromParent = true
        localContext.performAndWait {
            updates(localContext)
            if localContext.hasChanges {
                do {
                    try localContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
}
