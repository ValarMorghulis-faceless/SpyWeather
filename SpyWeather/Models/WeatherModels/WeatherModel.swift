//
//  WeatherModel.swift
//  SpyWeather
//
//  Created by Giorgi Samkharadze on 23.10.22.
//

import Foundation
import CoreLocation

class WeatherModel {
    var conditionId: Int = 1
    var cityName: String = "sasd"
    var temperature: Double = 2.34
    var longitude: CLLocationDegrees = 2.31
    var latitude: CLLocationDegrees = 4.123
    
    init(conditionId: Int, cityName: String,temperature: Double,longitude: CLLocationDegrees,  latitude: CLLocationDegrees) {
        self.conditionId = conditionId
        self.cityName = cityName
        self.temperature = temperature
        self.longitude = longitude
        self.latitude = latitude
    }
    
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    var conditionName: String {
        switch conditionId {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
                }
    }

}

