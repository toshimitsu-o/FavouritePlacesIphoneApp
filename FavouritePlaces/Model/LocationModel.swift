//
//  LocationModel.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 4/5/2023.
//

import Foundation
import MapKit

/// Location class model for map views and sunrise/sunset times
class Location: ObservableObject {
    /// Property for location name
    @Published var name = ""
    /// Property for latitude value
    @Published var latitude = -25.345
    /// Property for longitude value
    @Published var longitude = 131.03611
    /// Property for time zone
    @Published var timeZone: String?
    /// Property for sunrise time
    @Published var sunRiseTime: String?
    /// Property for sunset time
    @Published var sunSetTime: String?
    /// Property for delta  value
    @Published var delta = 0.1
    /// Property for region for map
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -25.345, longitude: 131.03611), span: MKCoordinateSpan(latitudeDelta: 30.0, longitudeDelta: 30.0))
    /// Location property to share
    static let shared = Location()
    
    /// Initialiser for location class instance
    init(name: String = "", latitude: Double = 25.345, longitude: Double = 131.03611, timeZone: String? = nil, sunRiseTime: String? = nil, sunSetTime: String? = nil, delta: Double = 0.1, region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -25.345, longitude: 131.03611), span: MKCoordinateSpan(latitudeDelta: 30.0, longitudeDelta: 30.0))) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.timeZone = timeZone
        self.sunRiseTime = sunRiseTime
        self.sunSetTime = sunSetTime
        self.delta = delta
        self.region = region
    }
}
