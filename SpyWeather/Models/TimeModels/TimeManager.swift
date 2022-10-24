//
//  TimeManager.swift
//  SpyWeather
//
//  Created by Giorgi Samkharadze on 23.10.22.
//

import Foundation
import CoreLocation

protocol TimeManagerDelegate {
    func didUpdateTime(_ timeManager: TimeManager, time2: TimeModel)
    func didFailWithError1(error: Error)
}

struct TimeManager {
    //var ara: WeatherModel?
    var delegate: TimeManagerDelegate?
    let timeURL = "https://timeapi.io/api/Time/current/coordinate?"

    func getTime(for latitude: Double , for longitude: Double){
        let urlString = "\(timeURL)latitude=\(latitude)&longitude=\(longitude)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                   if let time1 = self.parseJSON(timeData: safeData){
                       delegate?.didUpdateTime(self, time2: time1)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(timeData: Data) -> TimeModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(TimeData.self, from: timeData)
            
            let lastTime = decodedData.time
            let time1 = TimeModel(time: lastTime)
            let hours = time1.hours
            print(hours)
            return time1
        } catch {
            delegate?.didFailWithError1(error: error)
            print(error)
            return nil
        }
    }
}
