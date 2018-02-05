//
//  CoreDataStack.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation
import CoreData

// Using Nested Managed Object Context Pattern
// https://www.bignerdranch.com/blog/introducing-the-big-nerd-ranch-core-data-stack/
// store - coordinator - persisting MOC - Main MOC - Worker MOC

class CoreDataStack {
    
    lazy var persistingContext: NSManagedObjectContext = {
        let persistingContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        persistingContext.persistentStoreCoordinator = persistentStoreCoordinator
        persistingContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        persistingContext.undoManager = nil
        return persistingContext
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        let mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.parent = persistingContext
        mainContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        mainContext.undoManager = nil
        return mainContext
    }()
    
    lazy var workerContext: NSManagedObjectContext = {
        assert(!Thread.isMainThread)
        let workerContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        workerContext.parent = mainContext
        workerContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        workerContext.undoManager = nil
        return workerContext
    }()
    
    func performSave(in context: NSManagedObjectContext) -> Bool {
        var savedSuccessfully = true
        context.perform { [weak self] in
            if context.hasChanges {
                do {
                    try context.save()
                    savedSuccessfully = true
                } catch {
                    savedSuccessfully = false
                    print("Context save error: \(error)")
                }
                if let parent = context.parent {
                    if let unwrappedSelf = self {
                        savedSuccessfully = unwrappedSelf.performSave(in: parent)
                    }
                }
            }
        }
        return savedSuccessfully
    }
    
    private static let modelName = "Cache"
    
    private var persistentStoreURL: URL {
        let storeName = "\(CoreDataStack.modelName).sqlite"
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectoryURL.appendingPathComponent(storeName)
    }
    
    private let managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: CoreDataStack.modelName, withExtension: "momd") else {
            fatalError("Unable to get model url")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        return persistentStoreCoordinator
    }()
}
