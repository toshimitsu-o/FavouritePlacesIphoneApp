//
//  LocationView.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 4/5/2023.
//

import SwiftUI
import MapKit

struct LocationView: View {
    /// Get viewContext through environment
    //@Environment(\.managedObjectContext) private var viewContext
    /// Property to store Place item
    var place: Place
    
    @ObservedObject var model = Location.shared
    /// Property to store latitude for edit mode
    @State var latitude = "0.0"
    /// Property to store latitude for edit mode
    @State var longitude = "0.0"
    /// Property to store zoom size
    @State var zoom = 40.0
    /// State property to store edit mode state
    @State var isEditing = false
    
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
                    checkZoom()
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
            //checkMap()
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
        model.fromAddressToLocOld(updateViewLoc)
    }
    
    func updateViewLoc () {
        latitude = model.latStr
        longitude = model.longStr
    }
}

