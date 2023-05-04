//
//  LocationView.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 4/5/2023.
//

import SwiftUI
import MapKit

struct LocationView: View {
    /// Property to store Place item
    var place: Place
    
    @ObservedObject var model = Location.shared
    /// Property to store latitude for edit mode
    @State var latitude = "0.0"
    /// Property to store latitude for edit mode
    @State var longitude = "0.0"
    
    @State var zoom = 40.0
    
    var body: some View {
        VStack(alignment: .leading) {
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
            Slider(value: $zoom, in: 10...60) {
                if !$0 {
                    checkZoom()
                }
            }
            ZStack{
                Map(coordinateRegion: $model.region)
                VStack(alignment: .leading){
                    Text("Latitude:\(model.region.center.latitude)").font(.footnote)
                    Text("Longitude:\(model.region.center.longitude)").font(.footnote)
                    Button("Update"){
                        checkMap()
                    }
                }.offset(x:10, y: 280)
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
    func checkAddress(){
        model.fromAddressToLocOld(updateViewLoc)
        //        Task{
//            await model.fromAddressToLoc()
//            latitude = model.latStr
//            longitude = model.longStr
//        }
        
    }
    func checkLocation() {
        model.longStr = longitude
        model.latStr = latitude
        model.fromLocToAddress()
        model.setupRegion()
    }
    func checkZoom() {
        checkMap()
        model.fromZoomToDelta(zoom)
        model.fromLocToAddress()
        model.setupRegion()
    }
    func checkMap() {
        model.updateFromRegion()
        latitude = model.latStr
        longitude = model.longStr
        model.fromLocToAddress()
    }
    
    func updateViewLoc () {
        latitude = model.latStr
        longitude = model.longStr
    }
}

