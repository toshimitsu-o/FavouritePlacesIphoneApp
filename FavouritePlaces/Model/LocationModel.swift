//
//  LocationModel.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 4/5/2023.
//

import Foundation
import MapKit

/// Class for location model for map views
class Location: ObservableObject {
    /// Property for location name
    @Published var name = ""
    /// Property for latitude value
    @Published var latitude = -25.345
    /// Property for longitude value
    @Published var longitude = 131.03611
    /// Property for time zone
    @Published var timeZone: String?
    /// Property for delta  value
    @Published var delta = 0.1
    /// Property for region for map
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -25.345, longitude: 131.03611), span: MKCoordinateSpan(latitudeDelta: 30.0, longitudeDelta: 30.0))
    /// Location property to share
    static let shared = Location()
    
    init() {
        
    }
}
