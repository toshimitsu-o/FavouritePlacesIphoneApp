//
//  DetailView.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 20/4/2023.
//

import SwiftUI
import CoreData

/// Place item detail view to display details and edit attributes
struct DetailView: View {
    /// Get viewContext through environment
    @Environment(\.managedObjectContext) private var viewContext
    /// State property to store edit mode
    @State var isEditing = false
    /// Property to store Place item
    var place: Place
    /// Property to store name for edit mode
    @State var name = ""
    /// Property to store motes for edit mode
    @State var notes = ""
    /// Property to store latitude for edit mode
    @State var latitude = ""
    /// Property to store longitude for edit mode
    @State var longitude = ""
    /// Property to store UI image
    @State var image = defaultImage
    /// Property to store url of image as string
    @State var urlString = ""
    /// View to contain details of a Place item such as name, image, location details
    var body: some View {
        List {
            if isEditing {
                    Section(header: Text("Name")) {
                        TextField("Name", text: $name)
                    }
                    Section(header: Text("Notes")) {
                        TextField("Notes", text: $notes, axis: .vertical)
                            .lineLimit(2...10)
                    }
                    Section(header: Text("Latitude")) {
                        TextField("Latitude", text: $latitude)
                    }
                    Section(header: Text("Longitude")) {
                        TextField("Longitude", text: $longitude)
                    }
                    Section(header: Text("Image URL")) {
                        TextField("Image URL", text: $urlString, axis: .vertical)
                            .lineLimit(1...5)
                    }
            } else {
                image.scaledToFill().cornerRadius(10)
                Section(header: Text("Notes")) {
                    Text("Notes: \(place.notesString)")
                }
                Section(header: Text("Location")) {
                    Text("Latitude: \(place.latitudeString)")
                    Text("Longitude: \(place.longitudeString)")
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
        .navigationTitle(place.nameString)
        .toolbar {
            if isEditing {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        name = place.nameString
                        notes = place.notesString
                        latitude = place.latitudeString
                        longitude = place.longitudeString
                        urlString = place.urlString
                        isEditing.toggle()
                    }
                }
            }
        }
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
