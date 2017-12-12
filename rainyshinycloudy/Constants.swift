//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by Murat Kuran on 12/11/2017.
//  Copyright © 2017 Murat Kuran. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "b05ea5298e7c281cc98f7dc7ed12b93d"
let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)41.01\(LONGITUDE)28.95\(APP_ID)\(API_KEY)"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast?"
let DAY_COUNT = "&cnt="
let MODE = "&mode=json"
//let FORECAST_WEATHER_URL = "\(FORECAST_URL)\(LATITUDE)41.01\(LONGITUDE)28.95\(DAY_COUNT)06\(MODE)\(APP_ID)\(API_KEY)"

let FORECAST_WEATHER_URL = "http://samples.openweathermap.org/data/2.5/forecast/daily?lat=35&lon=139&cnt=10&appid=b1b15e88fa797225412429c1c50c122a1"

// Indicates that function is completed
typealias DownloadComplete = () -> ()


//let ACCU_WEATHER_FORECAST_URL = "\(ACCU_BASE_URL)\(ACCU_FORECAST)\(ACCU_LOCATION_ID)\(ACCU_API_KEY)"


