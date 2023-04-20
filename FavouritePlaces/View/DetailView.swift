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
    var place: Place
    @State var name = ""
    @State var notes = ""
    @State var image = ""
    var body: some View {
        VStack{
            Text("Name: \(place.name ?? "Name")")
            Text("Notes: \(place.notes ?? "Notes")")
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
