//
//  Persistence.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 20/4/2023.
//

import CoreData

/// Defining controller fo persistence
struct PersistenceController {
    /// Initiating persistance controller to share
    static let shared = PersistenceController()
    /// Container for persistent
    let container: NSPersistentContainer
    /// Initialisation for persistent container and loading stored data
    init() {
        container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores {
            storeDescription, error in
            if let error = error as NSError? {
                fatalError("Container load failed: \(error)")
            }
        }
    }
}
