//
//  MapThumbnailView.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 13/5/2023.
//

import SwiftUI
import MapKit
/// Sub view to display thumbnail map in detail view
struct MapThumbnailView: View {
    /// Property to store Place item
    var place: Place
    /// Property to assign location model object
    @StateObject var model = Location()
    /// View body to display Map with location model with latitude, logntitude details
    var body: some View {
        VStack(alignment: .leading) {
            Map(coordinateRegion: $model.region)
            HStack {
                Text("Latitude:\(model.region.center.latitude)").font(.system(size: 12, weight: .light))
                Text("Longitude:\(model.region.center.longitude)").font(.system(size: 12, weight: .light))
            }
        }
        .onAppear {
            model.latStr = place.latitudeString
            model.longStr = place.longitudeString
            model.setupRegion()
        }
    }
}

