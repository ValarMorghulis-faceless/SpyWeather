//
//  WeatherData.swift
//  SpyWeather
//
//  Created by Giorgi Samkharadze on 23.10.22.
//

import Foundation
import CoreLocation
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let coord: Coord
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
struct Coord: Codable {
    let lon: Double
    let lat: Double
}
