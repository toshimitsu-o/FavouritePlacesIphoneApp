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
fileprivate var downloadedImage: [URL: Image] = [:]

extension Place {
    /// Handle name attribute value to/from string
    var nameString: String {
        get {
            self.name ?? "No name"
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
        guard let url = imageURL else { return defaultImage }
        if let image = downloadedImage[url] { return image}
        do {
            let (data, _ ) = try await URLSession.shared.data(from: url)
            guard let uiImg = UIImage(data: data) else { return defaultImage }
            let image = Image(uiImage: uiImg).resizable()
            downloadedImage[url] = image
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
    let context = PersistenceController.shared.container.viewContext
    do {
        try context.save()
    } catch {
        print("An error occoured during saving: \(error)")
    }
}
