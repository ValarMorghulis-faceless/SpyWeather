//
//  TimeManager.swift
//  SpyWeather
//
//  Created by Giorgi Samkharadze on 23.10.22.
//

import Foundation


struct TimeManager {
    
    let ara: WeatherModel
    
    let timeURL = "https://timeapi.io/api/Time/current/coordinate?"

    let urlString = "\(timeURL)"
    
}
