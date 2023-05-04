//
//  LocationModel.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 4/5/2023.
//

import Foundation
import MapKit
class Location: ObservableObject {
    @Published var name = ""
    @Published var latitude = -25.345
    @Published var longitude = 131.03611
    @Published var delta = 0.1
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -25.345, longitude: 131.03611), span: MKCoordinateSpan(latitudeDelta: 30.0, longitudeDelta: 30.0))
    
    static let shared = Location()
    
    init() {
        
    }
}
