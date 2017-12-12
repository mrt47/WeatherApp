//
//  Forecast.swift
//  rainyshinycloudy
//
//  Created by Murat Kuran on 14/11/2017.
//  Copyright © 2017 Murat Kuran. All rights reserved.
//

import UIKit
import Alamofire

class Forecast{
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: String!
    private var _lowTemp: String!
    
    init (weatherObj: Dictionary<String, AnyObject>){
        if let temp = weatherObj["Temperature"] as? Dictionary <String, AnyObject>{
            if let min = temp["Minimum"] as? Dictionary<String, AnyObject> {
                if let minV = min["Value"] as? Double {
                    let tempToCelciusBeforeRound = (minV - 32) / 1.8
                    let tempToCelcius = Double(round(10 * tempToCelciusBeforeRound/10))
                    
                    self._lowTemp = "\(tempToCelcius)"
                }
            }
            if let max = temp["Maximum"] as? Dictionary<String, AnyObject> {
                if let maxV = max["Value"] as? Double {
                    let tempToCelciusBeforeRound = (maxV - 32) / 1.8
                    let tempToCelcius = Double(round(10 * tempToCelciusBeforeRound/10))
                    
                    self._highTemp = "\(tempToCelcius)"
                }

            }
        }
        
        if let weather = weatherObj["Day"] as? Dictionary<String, AnyObject> {
            if let weatherStatus = weather["IconPhrase"] as? String {
                self._weatherType = weatherStatus
            }
        }
        
        if let dt = weatherObj["EpochDate"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: dt)
            self._date = unixConvertedDate.dayOfWeek()
        }
        
        print("Forecast date: \(_date)")
        print("Forecast weather: \(_weatherType)")
        print("Forecast high temp: \(_highTemp)")
        print("Forecast low temp: \(_lowTemp)")
    }
    
    var date:String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType:String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp:String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp:String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
}

extension Date {
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
