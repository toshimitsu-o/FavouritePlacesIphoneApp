//
//  FavouritePlacesTests.swift
//  FavouritePlacesTests
//
//  Created by Toshimitsu Ota on 20/4/2023.
//

import XCTest
import CoreData
@testable import FavouritePlaces

final class FavouritePlacesTests: XCTestCase {
    
    /// Set context to use in unit test functions
    let context = PersistenceController.shared.container.viewContext
    
    /// Test nameString from Place to check if it set default value
    func testNameString() throws {
        /// New Place item
        let place = Place(context: context)
        /// Property to store value from nameString
        let name = place.nameString
        XCTAssertEqual(name, "No name")
    }
    
    /// Test notesString from Place to check if it set default value
    func testNotesString() throws {
        /// New Place item
        let place = Place(context: context)
        /// property to store value from notesString
        let notes = place.notesString
        XCTAssertEqual(notes, "No notes")
    }
    
    /// Test latitudeString from Place to check if it converts Double to srting
    func testLatitudeString() throws {
        /// New Place item
        let place = Place(context: context)
        place.latitude = 23.02
        /// Property to store value from latitudeString
        let latitudeString = place.latitudeString
        XCTAssertEqual(latitudeString, "23.02")
    }
    
    /// Test longitudeString from Place to check if it converts Double to srting
    func testLongitudeString() throws {
        /// New Place item
        let place = Place(context: context)
        place.longitude = 23.02
        /// Property to store value from longitudeString
        let longitudeString = place.longitudeString
        XCTAssertEqual(longitudeString, "23.02")
    }
    
    /// Test urlString from Place to check if it handle URL correctly
    func testUrlString() throws {
        /// New Place item
        let place = Place(context: context)
        /// Fake URL oft image
        let url = "http://www.no.no/img/no.png"
        place.urlString = url
        /// Property to store value from urlString
        let urlString = place.urlString
        XCTAssertEqual(urlString, url)
    }
    
    /// Test getImage method from Place to check if it return default image when image can't be downloaded
    func testGetImage() async throws {
        /// New Place item
        let place = Place(context: context)
        /// Fake URL oft image
        let url = "http://www.no.no/img/no.png"
        place.urlString = url
        /// Property to store result from getImage method
        let image = await place.getImage()
        XCTAssertEqual(image, defaultImage)
    }

}
