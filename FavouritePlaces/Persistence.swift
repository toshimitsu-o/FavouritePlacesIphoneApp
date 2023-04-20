//
//  Persistence.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 20/4/2023.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores {
            storeDescription, error in
            if let error = error as NSError? {
                fatalError("Container load failed: \(error)")
            }
        }
    }
}
