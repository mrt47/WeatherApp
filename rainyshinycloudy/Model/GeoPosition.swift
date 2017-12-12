//
//  GeoPosition.swift
//  rainyshinycloudy
//
//  Created by Murat Kuran on 17/11/2017.
//  Copyright © 2017 Murat Kuran. All rights reserved.
//

import UIKit
import Alamofire

class GeoPosition {
    private var _cityName: String!
    private var _cityKey: String!
    
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
    
    func downloadGeoPositionData(completed: @escaping DownloadComplete){
        let GEOPOSITION_SEARCH = "http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=noGY0ZdYNg1mpa5QzAFXf0Lpp7P38JPr&q=\(Location.sharedInstance.latitude!)%2C\(Location.sharedInstance.longitude!)"
        let geoURL = URL(string: GEOPOSITION_SEARCH)!
        print ("Geo Url: \(GEOPOSITION_SEARCH)")
        
        Alamofire.request(geoURL, method: .get).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let key = dict["Key"] as? String {
                    self._cityKey = key
                }

                if let name = dict["LocalizedName"] as? String{
                    self._cityName = name
                }
                
            }
            completed()
        }
    }
}
