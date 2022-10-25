//
//  ViewController.swift
//  SpyWeather
//
//  Created by Giorgi Samkharadze on 22.10.22.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeinfoLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    var weatherManager = WeatherManager()
    var timeManager = TimeManager()
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        timeManager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        searchTextField.delegate = self
        weatherManager.delegate = self
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}
var hours1 = 0

extension WeatherViewController: UITextFieldDelegate, WeatherManagerDelegate , TimeManagerDelegate{

    func didUpdateTime(_ timeManager: TimeManager, time2: TimeModel) {
        DispatchQueue.main.async {
            self.timeLabel.text = time2.time
        }
        hours1 = time2.hours
    }
    
    func didFailWithError1(error: Error) {
        print(error)
    }
    
    
    
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.getImage(hours: hours1))
            self.cityLabel.text = weather.cityName
            self.timeinfoLabel.text = "Current Time in \(weather.cityName)"
            self.descriptionLabel.text = weather.descriptioninfo
        }

        print(weather.conditionId)
        print(weather.temperatureString)
        print(weather.latitude)
        print(weather.longitude)
        timeManager.getTime(for: weather.latitude, for: weather.longitude)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)

        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        } else {
            textField.placeholder = "Type Something"
            return false
        }
    }
}
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
