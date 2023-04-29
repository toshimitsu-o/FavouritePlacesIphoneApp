//
//  DetailView.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 20/4/2023.
//

import SwiftUI
import CoreData

struct DetailView: View {
    /// Get viewContext through environment
    @Environment(\.managedObjectContext) private var viewContext
    /// State property to store edit mode
    @State var isEditing = false
    
    var place: Place
    @State var name = ""
    @State var notes = ""
    @State var latitude = ""
    @State var longitude = ""
    @State var image = defaultImage
    @State var urlString = ""
    var body: some View {
        VStack{
            image.scaledToFit().cornerRadius(20).shadow(radius: 20)
            if isEditing {
                TextField("Url:", text: $urlString)
                TextField("Name:", text: $name)
                TextField("Notes:", text: $notes)
                TextField("Latitude:", text: $latitude)
                TextField("Longitude:", text: $longitude)
            } else {
                List {
                    Text("Name: \(name)")
                    Text("Notes: \(notes)")
                    Text("Latitude: \(latitude)")
                    Text("Longitude: \(longitude)")
                }
            }
            Button("\(isEditing ? "Save" : "Edit")") {
                if isEditing {
                    place.nameString = name
                    place.notesString = notes
                    place.urlString = urlString
                    place.latitudeString = latitude
                    place.longitudeString = longitude
                    saveData()
                    Task {
                        image = await place.getImage()
                    }
                }
                isEditing.toggle()
            }
        }
        .navigationTitle(name)
        .onAppear {
            name = place.nameString
            notes = place.notesString
            latitude = place.latitudeString
            longitude = place.longitudeString
            urlString = place.urlString
        }
        .task {
            await image = place.getImage()
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
