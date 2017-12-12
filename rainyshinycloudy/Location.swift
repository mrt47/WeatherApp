//
//  Location.swift
//  rainyshinycloudy
//
//  Created by Murat Kuran on 15/11/2017.
//  Copyright © 2017 Murat Kuran. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude:Double!
    var longitude:Double!
}
