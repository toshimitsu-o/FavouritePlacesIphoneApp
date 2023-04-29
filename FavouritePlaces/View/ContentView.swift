//
//  ContentView.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 20/4/2023.
//

import SwiftUI

/// Main view to display navigation
struct ContentView: View {
    /// View to contain navigation view for a Place list
    var body: some View {
        NavigationView{
            PlaceListView()
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
