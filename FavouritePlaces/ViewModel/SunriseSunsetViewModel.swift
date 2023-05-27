//
//  SunriseSunsetViewModel.swift
//  FavouritePlaces
//
//  Created by Toshimitsu Ota on 26/5/2023.
//

import Foundation
import SwiftUI

/// Time zone struct for JOSN decoding
struct MyTimeZone: Decodable {
    /// Property for time zone
    var timeZone: String
}

/// Struct to store sunrise and sunset times
struct SunriseSunset: Codable {
    /// Sunrise time property
    var sunrise: String
    /// Sunset time property
    var sunset: String
}

/// Struct to store result and status from API for  JOSN coding
struct SunriseSunsetAPI: Codable {
    /// Result data from API call
    var results: SunriseSunset
    /// Status data from API call
    var status: String?
}

/// Extend Location class
extension Location {
    /// Property to convert time zone as string
    var timeZoneStr: String {
        if let tz = timeZone {
            return tz
        }
        fetchTimeZone()
        return ""
    }
    /// Property to convert sunrise time to string in local time
    var sunRiseStr: String {
        if let sr = sunRiseTime {
            let localTM = timeConvertFromGMTtoTimeZone(from: sr, to: self.timeZoneStr)
            return localTM
        }
        return ""
    }
    /// Property to convert sunset time to string in local time
    var sunSetStr: String {
        if let sr = sunSetTime {
            let localTM = timeConvertFromGMTtoTimeZone(from: sr, to: self.timeZoneStr)
            return localTM
        }
        return ""
    }
    /// Property for view to display sunrise string with an  icon image
    var sunRiseDisplay: some View {
        HStack {
            Image(systemName: "sunrise")
            if sunRiseStr != "" {
                Text(sunRiseStr)
            } else {
                ProgressView()
            }
        }
    }
    /// Property for view to display sunset string with an  icon image
    var sunSetDisplay: some View {
        HStack {
            Image(systemName: "sunset")
            if sunSetStr != "" {
                Text(sunSetStr)
            } else {
                ProgressView()
            }
        }
    }
    /// Fetch time zone using the latitude and longitude values of Location from time API and store in timeZone property. Then, call fetchSunriseInfor.
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
                self.fetchSunriseInfo()
            }
        }.resume()
    }
    
    /// Fetch sunrise and sunset times using the latitude and longitude values of Location from sunrise-sunset API and store them in sunRiseTime and  sunSetTime properties.
    func fetchSunriseInfo() {
        let urlStr = "https://api.sunrise-sunset.org/json?lat=\(latitude)&lng=\(longitude)"
        guard let url = URL(string: urlStr) else {
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data, let api = try? JSONDecoder().decode(SunriseSunsetAPI.self, from: data) else {
                return
            }
            DispatchQueue.main.async {
                self.sunRiseTime = api.results.sunrise
                self.sunSetTime = api.results.sunset
            }
        }.resume()
    }
    
    /// Convert GMT time to time in the given local time zone.
    ///
    /// - Parameter from: GMT time to convert from
    /// - Parameter to: Local timezone to convert the time to
    /// - Returns: Date string that stores time in local time when successful, otherwise, returns string unknown.
    func timeConvertFromGMTtoTimeZone(from tm:String, to timezone: String) -> String {
        /// Date formatter property for input
        let inputFormatter = DateFormatter()
        inputFormatter.dateStyle = .none
        inputFormatter.timeStyle = .medium
        inputFormatter.timeZone = .init(secondsFromGMT: 0)
        /// Date formatter property for output
        let outPutFormatter = DateFormatter()
        outPutFormatter.dateStyle = .none
        outPutFormatter.timeStyle = .short
        outPutFormatter.timeZone = TimeZone(identifier: timezone)
        
        if let time = inputFormatter.date(from: tm) {
            return outPutFormatter.string(from: time)
        }
        return "<unknown>"
    }
}
