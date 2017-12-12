//
//  WeatherVC.swift
//  rainyshinycloudy
//
//  Created by Murat Kuran on 10/11/2017.
//  Copyright © 2017 Murat Kuran. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherLbl: UILabel!
    
    var currentWeather: CurrentWeather!
    var geoPosition: GeoPosition!
    var forecastArr = [Forecast]()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var cityKey: String!
    var cityName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    // There are three functions needed to be implemented for table views
        // func numberOfSections
        // numberOfRowsInSection
        // func cellForRowAt
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            cell.configureCell(forecast: forecastArr[indexPath.row])
            
            // Give border and related color
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.orange.cgColor
            
            return cell
        }
        else {
            return WeatherCell()
        }
    }
    
    func updateUI(){
        dateLbl.text = currentWeather.date
        currentTempLbl.text = String(format:"%.0f", currentWeather.currentTemp) + "°"
        locationLbl.text = currentWeather.cityName
        currentWeatherLbl.text = currentWeather.weatherType
        currentWeatherImage.image = UIImage(named: "Clear")
    }
    
    // TODO: Burayi implemente et.
    func downloadForecastData(completed: @escaping DownloadComplete){
        let forecast_url = "http://dataservice.accuweather.com/forecasts/v1/daily/5day/\(self.cityKey!)?apikey=noGY0ZdYNg1mpa5QzAFXf0Lpp7P38JPr"
        let forecastURL = URL(string: forecast_url)!
        print ("forecastURL:\(forecast_url)")
        
        Alamofire.request(forecastURL, method: .get).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let list = dict["DailyForecasts"] as? [Dictionary<String, AnyObject>]{
                    for obj in list {
                        let forecast = Forecast(weatherObj: obj)
                        self.forecastArr.append(forecast)
                    }
                    self.forecastArr.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    

    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            print ("Latitude: \(Location.sharedInstance.latitude!)")
            print ("Longitude: \(Location.sharedInstance.longitude!)")
            
            geoPosition = GeoPosition()
            
            geoPosition.downloadGeoPositionData {
                self.cityKey = self.geoPosition.cityKey
                self.cityName = self.geoPosition.cityName
                print ("self.cityKey: \(self.cityKey), self.cityName: \(self.cityName)")
                self.currentWeather = CurrentWeather(cityKey: self.cityKey, city: self.cityName)
                print("self.currentWeather.cityKey: \(self.currentWeather.cityKey), self.currentWeather.cityName: \(self.currentWeather.cityName), self.currentWeather.currentUrl: \(self.currentWeather.currentUrl)")
                self.currentWeather.downloadWeatherDetails {
                    self.downloadForecastData {
                        self.updateUI()
                    }
                }
            }
        }
        else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }

}

