//
//  LocationViewModel.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 4/5/2023.
//

import Foundation
import CoreLocation
import SwiftUI

/// Extend Location class
extension Location {
    /// Latitude conversion from/to String/Double
    var latStr: String {
        get{String(format: "%.5f", latitude)}
        set{
            guard let lat = Double(newValue), lat <= 90.0, lat >= -90.0 else {return}
            latitude = lat
        }
    }
    /// Longitude conversion from/to String/Double
    var longStr: String {
        get{String(format: "%.5f", longitude)}
        set{
            guard let long = Double(newValue), long <= 180.0, long >= -180.0 else {return}
            longitude = long
        }
    }
    /// Update latitude and longitude from center location of region
    func updateFromRegion() {
        latitude = region.center.latitude
        longitude = region.center.longitude
    }
    /// Set up region in map with latitude, longitude, and delta
    func setupRegion() {
        withAnimation {
            region.center.latitude = latitude
            region.center.longitude = longitude
            region.span.longitudeDelta = delta
            region.span.latitudeDelta = delta
        }
    }
    /// Get address name from location details
    func fromLocToAddress() {
        /// Peroperty to point CLGeocoder
        let coder = CLGeocoder()
        coder.reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { marks, error in
            if let err = error {
                print("errof in fromLocToAddress: \(err)")
                return
            }
            let mark = marks?.first
            let name = mark?.name ?? mark?.country ?? mark?.locality ?? mark?.administrativeArea ?? "No name"
            self.name = name
        }
    }

    /// Get location details from address name. Then  perform a callback function, and set up region.
    ///
    /// - parameter cb: a callback function to perform
    func fromAddressToLoc(_ cb: @escaping ()->Void) {
        /// Assigning CLGeocoder as encoder
        let encode = CLGeocoder()
        encode.geocodeAddressString(self.name) { marks, error in
            if let err = error {
                print("errof in fromAddressToLoc \(err)")
                return
            }
            if let mark = marks?.first {
                self.latitude = mark.location?.coordinate.latitude ?? self.latitude
                self.longitude = mark.location?.coordinate.longitude ?? self.longitude
                cb()
                self.setupRegion()
            }
        }
    }

    /// Convert zoom value to delta value
    ///
    ///  - parameter zoom: zoom value to convert to delta
    func fromZoomToDelta(_ zoom: Double){
        /// c1 property value for calculation
        let c1 = -10.0
        /// c2 property value for calculation
        let c2 = 3.0
        delta = pow(10.0, zoom / c1 + c2)
    }
}
