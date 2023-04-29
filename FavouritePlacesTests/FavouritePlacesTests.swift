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
    
    let context = PersistenceController.shared.container.viewContext

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNameString() throws {
        let place = Place(context: context)
        let name = place.nameString
        XCTAssertEqual(name, "No name")
    }
    
    func testNotesString() throws {
        let place = Place(context: context)
        let notes = place.notesString
        XCTAssertEqual(notes, "No notes")
    }
    
    func testLatitudeString() throws {
        let place = Place(context: context)
        place.latitude = 23.02
        let latitudeString = place.latitudeString
        XCTAssertEqual(latitudeString, "23.02")
    }
    
    func testLongitudeString() throws {
        let place = Place(context: context)
        place.longitude = 23.02
        let longitudeString = place.longitudeString
        XCTAssertEqual(longitudeString, "23.02")
    }
    
    func testUrlString() throws {
        let place = Place(context: context)
        let url = "http://www.no.no/img/no.png"
        place.urlString = url
        let urlString = place.urlString
        XCTAssertEqual(urlString, url)
    }
    
    func testGetImage() async throws {
        let place = Place(context: context)
        let url = "http://www.no.no/img/no.png"
        place.urlString = url
        let image = await place.getImage()
        XCTAssertEqual(image, defaultImage)
    }

}
