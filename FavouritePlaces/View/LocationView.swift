//
//  LocationView.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 4/5/2023.
//

import SwiftUI
import MapKit

/// View to display a location on map with edit mode to update the location
struct LocationView: View {
    /// Property to store Place item
    var place: Place
    /// Assign the shared location model instance
    @ObservedObject var model = Location.shared
    /// Property to store latitude for edit mode
    @State var latitude = "0.0"
    /// Property to store latitude for edit mode
    @State var longitude = "0.0"
    /// Property to store zoom size
    @State var zoom = 40.0
    /// State property to store edit mode state
    @State var isEditing = false
    /// View body to display map and text fields to update the location in edit mode
    var body: some View {
        VStack {
            if isEditing {
                HStack{
                    Text("Address")
                    TextField("Address", text: $model.name)
                    Image(systemName: "sparkle.magnifyingglass").foregroundColor(.blue)
                        .onTapGesture {
                            checkAddress()
                        }
                }
                HStack{
                    Text("Lat/Long")
                    TextField("Lat:", text: $latitude)
                    TextField("Long:", text: $longitude)
                    Image(systemName: "sparkle.magnifyingglass").foregroundColor(.blue)
                        .onTapGesture {
                            checkLocation()
                        }
                }
            }
            Slider(value: $zoom, in: 10...60) {
                if !$0 {
                    setZoom()
                }
            }
            ZStack(alignment: .bottom) {
                Map(coordinateRegion: $model.region)
                if isEditing {
                    HStack {
                        VStack(alignment: .leading){
                            Text("Latitude:\(model.region.center.latitude)").font(.system(size: 12, weight: .light))
                            Text("Longitude:\(model.region.center.longitude)").font(.system(size: 12, weight: .light))
                        }
                        Button("Use Center"){
                            checkMap()
                        }
                    }
                    .padding(8)
                    .background(.white.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .offset(x:0, y: -10)
                }
            }
            if (isEditing) {
                Button(action: {
                    place.nameString = model.name
                    place.latitudeString = latitude
                    place.longitudeString = longitude
                    saveData()
                }){Text("Update Location")}
            }
        }
        .navigationTitle(place.nameString)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isEditing {
                    Button(action: {
                        isEditing.toggle()
                    }){Text("Cancel")}
                } else {
                    Button(action: {
                        isEditing.toggle()
                    }){Text("Edit")}
                }
            }
        }
        .onAppear {
            latitude = place.latitudeString
            longitude = place.longitudeString
            model.longStr = longitude
            model.latStr = latitude
            model.setupRegion()
        }
    }
    /// Get location details from address name
    func checkAddress(){
        model.fromAddressToLoc(updateViewLoc)
    }
    /// Get address name and set region from location details
    func checkLocation() {
        model.longStr = longitude
        model.latStr = latitude
        model.fromLocToAddress()
        model.setupRegion()
    }
    /// Update map delta from the zoom value
    func setZoom() {
        checkMap()
        model.fromZoomToDelta(zoom)
        model.fromLocToAddress()
        model.setupRegion()
    }
    /// Set center location of region to the new location
    func checkMap() {
        model.updateFromRegion()
        latitude = model.latStr
        longitude = model.longStr
        model.fromAddressToLoc(updateViewLoc)
    }
    /// Uopdate location details in the view from model
    func updateViewLoc () {
        latitude = model.latStr
        longitude = model.longStr
    }
}

