//
//  PlaceRowView.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 29/4/2023.
//

import SwiftUI

struct PlaceRowView: View {
    var place: Place
    @State var image = defaultImage
    var body: some View {
        HStack {
            image.frame(width: 50, height: 50).clipShape(Circle())
            Text(place.nameString)
            VStack {
                Text(place.latitudeString).font(.system(size: 10, weight: .light))
                Text(place.longitudeString).font(.system(size: 10, weight: .light))
            }
        }
        .task {
            await image = place.getImage()
        }
    }
}

//struct PlaceRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceRowView()
//    }
//}
