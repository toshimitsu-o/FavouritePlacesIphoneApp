//
//  PlaceListView.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 29/4/2023.
//

import SwiftUI
import CoreData

struct PlaceListView: View {
    /// Get viewContext through environment
    @Environment(\.managedObjectContext) private var viewContext
    /// Fetch request to get entity in Place
    @FetchRequest(entity: Place.entity(), sortDescriptors: [NSSortDescriptor(key: "position", ascending: true)])
    /// Private variable for result from fetching
    private var places: FetchedResults<Place>
    ///
    //private var tempPlaces: [Place] = []
    /// Environment property for edit mode
    @Environment(\.editMode) private var editMode
    
    var body: some View {
            VStack {
                List{
                    ForEach(places) {
                        place in
                        NavigationLink(destination: DetailView(place: place)) {
                            PlaceRowView(place: place)
                        }
                    }
                    .onDelete {
                        index in
                        deletePlace(index)
                        saveData()
                    }
                    .onMove{
                        index, position in
                        movePlace(index, position)
                        saveData()
                    }
                }
            }
            .navigationTitle("My Favourite Places")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Add new item
                        addPlace()
                        saveData()
                    }){Image(systemName: "plus.circle")}
                }
            }
    }
    
    private func addPlace() {
        withAnimation{
            let place = Place(context: viewContext)
            place.name = "New place"
            place.position = sortPlaces()
            saveData()
        }
    }
    
    private func deletePlace(_ index: IndexSet) {
        withAnimation{
            index.map{places[$0]}.forEach{
                place in viewContext.delete(place)
            }
        }
    }
    
    /// Update position attribute of Place items to the new order of items in List. Changes made to reference type copied places array will update the core data automatically. (Source: https://stackoverflow.com/questions/59742218/swiftui-reorder-coredata-objects-in-list)
    ///
    /// - parameter index:
    private func movePlace(_ index: IndexSet, _ position: Int) {
        /// Make a copy array of items
        var movingItems = places.map{$0}
        /// Change orders of items to new potitions
        movingItems.move(fromOffsets: index, toOffset: position)
        /// Update position attributes in reversed order to minimise changes
        for reverseIndex in stride(from: movingItems.count - 1, through: 0, by: -1) {
            movingItems[reverseIndex].position = Int16(reverseIndex)
        }
    }
    
    private func sortPlaces() -> Int16 {
        var position: Int16 = 0
        places.forEach{
            place in
            place.position = position
            position += 1
        }
        return position
    }
}
