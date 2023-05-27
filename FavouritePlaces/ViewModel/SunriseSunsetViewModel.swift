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

struct SunriseSunset: Codable {
    var sunrise: String
    var sunset: String
}

struct SunriseSunsetAPI: Codable {
    var results: SunriseSunset
    var status: String?
}

extension Location {
    var timeZoneStr: String {
        if let tz = timeZone {
            return tz
        }
        fetchTimeZone()
        return ""
    }
    
    var sunRiseStr: String {
        if let sr = sunRiseTime {
            let localTM = timeConvertFromGMTtoTimeZone(from: sr, to: self.timeZoneStr)
            return localTM
        }
        return ""
    }
    
    var sunSetStr: String {
        if let sr = sunSetTime {
            let localTM = timeConvertFromGMTtoTimeZone(from: sr, to: self.timeZoneStr)
            return localTM
        }
        return ""
    }
    
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
    
    func timeConvertFromGMTtoTimeZone(from tm:String, to timezone: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateStyle = .none
        inputFormatter.timeStyle = .medium
        inputFormatter.timeZone = .init(secondsFromGMT: 0)
        
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
