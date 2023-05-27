//
//  FavouritePlacesApp.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 20/4/2023.
//

import SwiftUI

/// Root of the app
@main
struct FavouritePlacesApp: App {
    /// Asign the shared persistence controller
    let persistenceController = PersistenceController.shared
    /// Initialiser
    init() {
        /// Change color of navigation bar title
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemGreen]
        }
    /// The main scene for the app with viewContext
    var body: some Scene {
        WindowGroup {
            /// Pass view context through environment using keypath
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
