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
        VStack() {
            HStack {
                model.sunRiseDisplay
                model.sunSetDisplay
            }
            HStack {
                Text("Local Time Zone: ").font(.system(size: 12, weight: .light))
                if model.timeZoneStr != "" {
                    Text(model.timeZoneStr).font(.system(size: 12, weight: .light))
                } else {
                    ProgressView()
                }
            }.padding(2)
        }
        .onAppear {
            model.latStr = place.latitudeString
            model.longStr = place.longitudeString
        }
    }
}
