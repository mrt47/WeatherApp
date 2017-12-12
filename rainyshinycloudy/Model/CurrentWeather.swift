//
//  currentWeather.swift
//  rainyshinycloudy
//
//  Created by Murat Kuran on 12/11/2017.
//  Copyright © 2017 Murat Kuran. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    private var _cityKey: String!
    private var _currentUrl:String!
    
    init(cityKey:String, city:String){
        self._cityName = city
        self._cityKey = cityKey
        self._currentUrl = "http://dataservice.accuweather.com/forecasts/v1/daily/1day/\(_cityKey!)?apikey=noGY0ZdYNg1mpa5QzAFXf0Lpp7P38JPr"
    }
    
    var cityKey:String {
        get{
            if _cityKey == nil {
                return ""
            } else {
                return _cityKey
            }
        } set {
            self._cityKey = newValue
        }
    }
    
    var currentUrl:String {
        get{
            if _currentUrl == nil {
                return ""
            } else {
                return _currentUrl
            }
        } set {
            self._currentUrl = newValue
        }
    }
    
    var cityName:String {
        get{
            if _cityName == nil {
                return ""
            } else {
                return _cityName
            }
        } set {
            self._cityName = newValue
        }
    }
    
    var date:String {
        if _date == nil {
            _date = ""
        }
        // Format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        // Convert date format to string
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType:String {
        get{
            if _weatherType == nil {
                return ""
            } else {
                return _weatherType
            }
        } set {
            self._weatherType = newValue
        }
    }
    
    var currentTemp:Double {
        get {
            if _currentTemp == nil {
                return 0.0
            } else {
                return _currentTemp
            }
        } set {
            self._currentTemp = newValue
        }
    }
    
//    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
//        // Convert string to URL
//        print(CURRENT_WEATHER_URL)
//        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
//
//        // Send request via Alamofire and get response.result
//        Alamofire.request(currentWeatherURL, method: .get).responseJSON{ response in
//            let result = response.result
//            //print(result)
//
//            if let dict = result.value as? Dictionary<String, AnyObject>{
//                if let city = dict["name"] as? String {
//                    self._cityName = city.capitalized
//                    print (self._cityName)
//                }
//
//                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
//                    if let weather_main = weather[0]["main"] as? String{
//                        self._weatherType = weather_main
//                        print(self._weatherType)
//                    }
//                }
//
//                if let main = dict["main"] as? Dictionary<String, AnyObject>{
//                    if let temp = main["temp"] as? Double{
//                        let tempToCelciusBeforeRound = temp - 273.15
//                        let tempToCelcius = Double(round(10 * tempToCelciusBeforeRound/10))
//
//                        self._currentTemp = tempToCelcius
//                        print(self._currentTemp)
//                    }
//                }
//            }//end of dict
//            completed() // It shows that function is completed
//        } //end of request
//    }
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        // Convert string to URL
        print("Current Weather Url: \(_currentUrl)")
        let currentWeatherURL = URL(string: _currentUrl)!

        // Send request via Alamofire and get response.result
        Alamofire.request(currentWeatherURL, method: .get).responseJSON{ response in
            let result = response.result
            //print(result)

            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let daily = dict["DailyForecasts"] as? [Dictionary<String, AnyObject>]{
                    if let temp = daily[0]["Temperature"] as? Dictionary<String,AnyObject> {
                        if let max = temp["Maximum"] as? Dictionary <String, AnyObject> {
                            if let val = max["Value"] as? Double {
                                let tempToCelciusBeforeRound = (val - 32) / 1.8
                                let tempToCelcius = Double(round(10 * tempToCelciusBeforeRound/10))

                                self._currentTemp = tempToCelcius
                                print(self._currentTemp)
                            }
                        }
                    }
                    if let dy = daily[0]["Day"] as? Dictionary<String, AnyObject>{
                        if let phrase = dy["IconPhrase"] as? String {
                            self._weatherType = phrase
                            print(self._weatherType)
                        }
                    }
                }
            }//end of dict
            print ("Current_cityName: \(self._cityName)")
            print ("Current_cityKey: \(self._cityKey)")
            //print ("Current_date: \(self._date)")

            completed() // It shows that function is completed
        } //end of request
    }// end of function
}
