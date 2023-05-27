//
//  PlaceRowView.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 29/4/2023.
//

import SwiftUI

/// Row view containg Place item name and image for the list of Place items
struct PlaceRowView: View {
    /// Property for storing Place item
    @StateObject var place: Place
    /// Property to store image
    @State var image = defaultImage
    /// View to contain Row  with image, name of a Place item
    var body: some View {
        HStack {
            image.frame(width: 50, height: 50).clipShape(Circle())
            Text(place.nameString)
        }
        .task {
            await image = place.getImage()
        }
    }
}
