//
//  WeatherManager.swift
//  SpyWeather
//
//  Created by Giorgi Samkharadze on 23.10.22.
//

import Foundation
import CoreLocation


protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL =  "https://api.openweathermap.org/data/2.5/weather?appid=b6e48b90f5c4f49c50af3f9ec7c0a01f&units=metric"
    
    func fetchWeather (cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(urlString: urlString)
        
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
    }
    func performRequest(urlString: String) {
        //1. url is created
        if let url = URL(string: urlString){
            
            
            
            //2. Create a URLSession
            
            let session = URLSession(configuration: .default)
            
            //3. Give the session the task
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSon(weatherData: safeData){
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    
    
    func parseJSon(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
      let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let deskrpt = decodedData.weather[0].description
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let lon = decodedData.coord.lon
            let lat = decodedData.coord.lat
            let weather = WeatherModel(descriptioninfo: deskrpt, conditionId: id, cityName: name, temperature: temp, longitude: lon, latitude: lat)
            print(weather.longitude)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
   
}
