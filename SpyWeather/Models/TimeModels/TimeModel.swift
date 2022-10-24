//
//  TimeModel.swift
//  SpyWeather
//
//  Created by Giorgi Samkharadze on 24.10.22.
//

import Foundation

struct TimeModel {
    var time: String
    
    var hours: Int {
        return Int(time.prefix(2))!
    }
}
