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
    
    @StateObject var model = Location()
    
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
            //checkMap()
        }
    }
}
