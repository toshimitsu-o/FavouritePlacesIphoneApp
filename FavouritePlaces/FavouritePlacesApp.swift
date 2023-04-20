//
//  FavouritePlacesApp.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 20/4/2023.
//

import SwiftUI

@main
struct FavouritePlacesApp: App {
    /// Asign the shared persistence controller
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            /// Pass view context through environment using keypath
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
