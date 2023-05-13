//
//  MapThumbnailView.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 13/5/2023.
//

import SwiftUI
import MapKit

struct MapThumbnailView: View {
    /// Get viewContext through environment
    //@Environment(\.managedObjectContext) private var viewContext
    /// Property to store Place item
    var place: Place
    
    @ObservedObject var model = Location.shared
    /// Property to store latitude for edit mode
    @State var latitude = "0.0"
    /// Property to store latitude for edit mode
    @State var longitude = "0.0"
    
    var body: some View {
        VStack(alignment: .leading) {
            Map(coordinateRegion: $model.region)
            HStack {
                Text("Latitude:\(model.region.center.latitude)").font(.system(size: 12, weight: .light))
                Text("Longitude:\(model.region.center.longitude)").font(.system(size: 12, weight: .light))
            }
        }
        .onAppear {
            latitude = place.latitudeString
            longitude = place.longitudeString
            model.longStr = longitude
            model.latStr = latitude
            model.setupRegion()
            //checkMap()
        }
    }
}

