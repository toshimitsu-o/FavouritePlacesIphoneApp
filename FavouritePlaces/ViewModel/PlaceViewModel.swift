//
//  PlaceViewModel.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 29/4/2023.
//

import Foundation
import CoreData
import SwiftUI

/// Default image for when there is no iamge
let defaultImage = Image(systemName: "photo")
/// Local cache for downloaded image
var downloadedImage: [URL: Image] = [:]

/// Extending Place with methods and properties to handle attributes with String
extension Place {
    /// Handle name attribute value to/from string
    var nameString: String {
        get {
            return self.name ?? "No name"
        }
        set {
            self.name = newValue
        }
    }
    /// Handle notes attribute value to/from string
    var notesString: String {
        get {
            self.notes ?? "No notes"
        }
        set {
            self.notes = newValue
        }
    }
    /// Handle latitude attribute value to/from string
    var latitudeString: String {
        get {
            "\(self.latitude)"
        }
        set {
            guard let latitude = Double(newValue) else {
                return
            }
            self.latitude = latitude
        }
    }
    /// Handle longitude attribute value to/from string
    var longitudeString: String {
        get {
            "\(self.longitude)"
        }
        set {
            guard let longitude = Double(newValue) else {
                return
            }
            self.longitude = longitude
        }
    }
    /// Handle url string for image
    var urlString: String {
        get { imageURL?.absoluteString ?? "" }
        set { guard let url = URL(string: newValue) else { return }
            imageURL = url
        }
    }
    /// Download image from imageURL and set as resizable UIImage. If it's already saved return the cached image.  If it fails set defaultImage.
    ///
    ///  - returns: Image. If download fails, return defaultImage. If already downloaded, return cached downloadedImage.
    func getImage() async -> Image {
        ///  URL of image
        guard let url = imageURL else { return defaultImage }
        if let image = downloadedImage[url] { return image}
        do {
            let (data, _ ) = try await URLSession.shared.data(from: url)
            guard let uiImg = UIImage(data: data) else { return defaultImage }
            let image = Image(uiImage: uiImg).resizable()
            DispatchQueue.main.async {
                downloadedImage[url] = image
            }
            return image
        }
        catch {
            print("Error downloading \(url): \(error.localizedDescription)")
        }
        return defaultImage
    }
}

/// Save context. When error, print error message.
func saveData() {
    /// Shared view context
    let context = PersistenceController.shared.container.viewContext
    do {
        try context.save()
    } catch {
        print("An error occoured during saving: \(error)")
    }
}

/// Add a place with a default name at the given position and save to context.
///
///  - parameter position: Position to add a new place at.
func addPlace(_ position: Int16) {
    /// Shared view context
    let context = PersistenceController.shared.container.viewContext
    /// Creating a new Place
    let place = Place(context: context)
    place.name = "New place"
    place.position = position
    saveData()
}

/// Delete places and save context
///
///  - parameter places: Array of place objects to delete
func deletePlaces(_ places: [Place]) {
    /// Shared view context
    let context = PersistenceController.shared.container.viewContext
    places.forEach{
        context.delete($0)
    }
    saveData()
}

/// Create Place items from sample data and save as default Place items
func loadDefaultData() {
    /// Array of place details for default places
    let defaultPlaces = [
        ["Sydney","The capital city of the state of New South Wales, and the most populous city in Australia.", -33.8678500, 151.2073200, "https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Sydney_CBD_skyline%2C_January_2021.jpg/800px-Sydney_CBD_skyline%2C_January_2021.jpg", 0],
        ["Brisbane","The capital and most populous city of Queensland.", -27.46794, 153.02809, "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Michaelmano-story-bridge.jpg/800px-Michaelmano-story-bridge.jpg", 1],
        ["Melbourne","The capital of the Australian state of Victoria, and the second-most populous city in Australia.", -37.814, 144.96332, "https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Melburnian_Skyline.jpg/800px-Melburnian_Skyline.jpg", 2]
        ]
    /// Shared view context
    let context = PersistenceController.shared.container.viewContext
    
    defaultPlaces.forEach {
        let place = Place(context: context)
        place.nameString = $0[0] as! String
        place.notesString = $0[1] as! String
        place.latitude = $0[2] as! Double
        place.longitude = $0[3] as! Double
        place.urlString = $0[4] as! String
        place.position = Int16($0[5] as! Int)
    }
    saveData()
}
