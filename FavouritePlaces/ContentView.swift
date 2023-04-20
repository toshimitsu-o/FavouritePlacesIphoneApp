//
//  ContentView.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 20/4/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    /// Get viewContext through environment
    @Environment(\.managedObjectContext) private var viewContext
    /// Place name as state variable
    @State var placeName: String = ""
    /// Fetch request to get entity in Place
    @FetchRequest(entity: Place.entity(), sortDescriptors: [])
    /// Private variable for result from fetching
    private var places: FetchedResults<Place>
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("Place name", text: $placeName)
                HStack{
                    Spacer()
                    Button("Add"){
                        addPlace()
                        placeName = ""
                    }
                    Spacer()
                    Button("Clear"){
                        placeName = ""
                    }
                    Spacer()
                }
                List{
                    ForEach(places) {
                        place in Text(place.name ?? "No name")
                    }
                }
            }
            .navigationTitle("My Favourite Places")
        }
    }
    
    private func addPlace() {
        withAnimation{
            let place = Place(context: viewContext)
            place.name = placeName
            saveContext()
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("An error occoured during saving: \(error)")
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
