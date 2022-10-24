//
//  WeatherModel.swift
//  SpyWeather
//
//  Created by Giorgi Samkharadze on 23.10.22.
//

import Foundation
import CoreLocation

struct WeatherModel {
    var conditionId: Int
    var cityName: String
    var temperature: Double
    var longitude: Double
    var latitude: Double
    
    
    
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
    func getImage(hours: Int) -> String {
        
        if conditionId > 200 && conditionId < 232 && hours > 6 && hours < 18 {
            return "cloud.bolt"
        } else if conditionId > 200 && conditionId < 232 && hours < 6 || hours > 18 {
            return "cloud.moon.bolt"
        } else if conditionId > 300 && conditionId < 321 && hours > 6 && hours < 18 {
            return "cloud.drizzle"
        } else if conditionId > 300 && conditionId < 321 && hours < 6 || hours > 18 {
            return "cloud.moon.rain"
        } else if conditionId > 500 && conditionId < 531 && hours > 6 && hours < 18 {
            return "cloud.rain"
        }else if conditionId > 500 && conditionId < 531 && hours < 6 || hours > 18 {
            return "cloud.moon.rain"
        } else {
            return "cloud"
        }
        
        
        
    }
}

