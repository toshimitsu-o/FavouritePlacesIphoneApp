//
//  SunriseSunsetView.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 26/5/2023.
//

import SwiftUI

struct SunriseSunsetView: View {
    /// Property to store Place item
    var place: Place
    /// Property to assign location model object
    @StateObject var model = Location()
    /// View body to display Map with location model with latitude, logntitude details
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if model.timeZoneStr != "" {
                    Text("TimeZone:\(model.timeZoneStr)").font(.system(size: 12, weight: .light))
                } else {
                    ProgressView()
                }
            }
            model.sunRiseDisplay
            model.sunSetDisplay
        }
        .onAppear {
            model.latStr = place.latitudeString
            model.longStr = place.longitudeString
        }
    }
}
