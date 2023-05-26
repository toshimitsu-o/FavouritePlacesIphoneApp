//
//  SunriseSunsetViewModel.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 26/5/2023.
//

import Foundation
import SwiftUI

struct MyTimeZone: Decodable {
    var timeZone: String
}

extension Location {
    var timeZoneStr: String {
        if let tz = timeZone {
            return tz
        }
        fetchTimeZone()
        return ""
    }
    
    func fetchTimeZone() {
        let urlStr = "https://www.timeapi.io/api/TimeZone/coordinate?latitude=\(latitude)&longitude=\(longitude)"
        guard let url = URL(string: urlStr) else {
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data, let api = try? JSONDecoder().decode(MyTimeZone.self, from: data) else {
                return
            }
            DispatchQueue.main.async {
                self.timeZone = api.timeZone
                // self.fetchSunriseInfo()
            }
        }.resume()
    }
}
