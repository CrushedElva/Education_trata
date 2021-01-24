//
//  CoreDataService.swift
//  education_trata_swift
//
//  Created by 18577745 on 01.09.2020.
//  Copyright © 2020 16700097. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataServiceProtocol {

    func operationWithContext(changeOperation: @escaping((NSManagedObjectContext) -> ()))
    
    func create<EntityType>(type: EntityType.Type, updateData: @escaping((EntityType) -> ())) throws -> EntityType? where EntityType: NSManagedObject
    
    func fetch<EntityType>(entity: EntityType.Type, predicate: NSPredicate?, sortDescriptor: NSSortDescriptor?, completion: @escaping(([EntityType]) -> ())) throws where EntityType: NSManagedObject
    
    func deleteEntity(entityID: NSManagedObjectID)
    
    func saveContext()
}

class CoreDataService: CoreDataServiceProtocol {

    static let instance: CoreDataServiceProtocol = CoreDataService()
    
    private init() {
        initializer()
    }
    
    private let mainQueue = DispatchQueue(label: "mainQueue", qos: .background, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
    
    private let context: NSManagedObjectContext = {
        guard let modelURL = Bundle.main.url(forResource: "education_trata_swift", withExtension: "momd") else {
            fatalError("Failed to find data model")
        }
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError()
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let fileURL = URL(string: "DataModel.sql", relativeTo: dirURL)!
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: fileURL, options: nil)
        } catch {
            fatalError("Error configuring persistent store: \(error)")
        }
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = psc
        
        return context
    }()
    
    func saveContext() {
        do {
            try context.save()
        } catch let error {
            print("Error saving context \(error)")
        }
    }
    
    func operationWithContext(changeOperation: @escaping((NSManagedObjectContext) -> ())) {
        context.saveWithBlockAndWait { (localContext) in
            changeOperation(localContext)
        }
    }
    
    func create<EntityType>(type: EntityType.Type, updateData: @escaping((EntityType) -> ())) throws -> EntityType? where EntityType: NSManagedObject {
        let entityName = String(describing: type)
        var objectID: NSManagedObjectID?
        context.saveWithBlockAndWait { (localContext) in
            let entity = NSEntityDescription.insertNewObject(forEntityName: entityName, into: localContext) as! EntityType
            updateData(entity)
            objectID = entity.objectID
        }
        do {
            let createdEntity = try context.existingObject(with: objectID!) as! EntityType
            return createdEntity
        } catch let error {
            print("error \(error.localizedDescription)")
            return nil
        }
    }
        
    func fetch<EntityType>(entity: EntityType.Type, predicate: NSPredicate?, sortDescriptor: NSSortDescriptor?, completion: @escaping(([EntityType]) -> ())) throws where EntityType: NSManagedObject {
        let entityName = String(describing: entity)
        context.saveWithBlockAndWait { (localContext) in
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.predicate = predicate
            if let sort = sortDescriptor {
                fetchRequest.sortDescriptors = [sort]
            }
            do {
                let entities = try localContext.fetch(fetchRequest) as! [EntityType]
                completion(entities)
            } catch let error {
                print("Can't fetch entities \(error.localizedDescription)")
            }
        }
    }
    
    func deleteEntity(entityID: NSManagedObjectID) {
        context.saveWithBlockAndWait { (localContext) in
            do {
                let entity = try localContext.existingObject(with: entityID)
                localContext.delete(entity)
            } catch let error {
                print("Fail: can't delete entity by ID \(error.localizedDescription)")
            }
        }
    }
}

private extension CoreDataService {
    
    private func checkEntityListExists<EntityType>(type: EntityType, completion: @escaping(Bool) -> ()) {
        do {
            try fetch(entity: type.self as! NSManagedObject.Type, predicate: nil, sortDescriptor: nil, completion: { (entityArray) in
                completion(entityArray.isEmpty)
            })
        } catch let error {
            print("\(error.localizedDescription)")
        }
    }
    
    private func initializer() {

        checkEntityListExists(type: Category.self, completion: { (isEmpty: Bool) -> () in
            if isEmpty {
                for counter in DefaultDataModels.Category.allCases {
                    do {
                        _ = try self.create(type: Category.self, updateData: { (entity: Category) -> () in
                            entity.name = counter.contentOfEntity.0
                            entity.iconName = counter.contentOfEntity.1
                            entity.order = Int16(counter.rawValue)
                            print("create Category with name: \(String(describing: entity.name!))")})
                    } catch let error {
                            print("Error in creating Category Collection \(error.localizedDescription)")
                    }
                }
            }
        })

        checkEntityListExists(type: Currency.self, completion: { (isEmpty: Bool) -> () in
            if isEmpty {
                for counter in DefaultDataModels.Currency.allCases {
                    do {
                        _ = try self.create(type: Currency.self, updateData: { (entity: Currency) -> () in
                            entity.name = counter.contentOfEntity.0
                            entity.symbol = counter.contentOfEntity.1
                            entity.order = Int16(counter.rawValue)
                            print("create Currency with name: \(String(describing: entity.name!))")})
                    } catch let error {
                            print("Error in creating Currency Collection \(error.localizedDescription)")
                    }
                }
            }
        })
        
        checkEntityListExists(type: Spendings.self, completion: { (isEmpty: Bool) -> () in
            if isEmpty {
                for counter in DefaultDataModels.Spendings.allCases {
                    do {
                        _ = try self.create(type: Spendings.self, updateData: { (entity: Spendings) -> () in
                            entity.name = counter.contentOfEntity.0
                            entity.icon = counter.contentOfEntity.1
                            entity.cash = counter.contentOfEntity.2
                            entity.order = Int16(counter.rawValue)
                            print("create Currency with name: \(String(describing: entity.name!))")})
                    } catch let error {
                            print("Error in creating Currency Collection \(error.localizedDescription)")
                    }
                }
            }
        })

        if context.hasChanges {
            mainQueue.sync {
                saveContext()
            }
        }
    }
}
