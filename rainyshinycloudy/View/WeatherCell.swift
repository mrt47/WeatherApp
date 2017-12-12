//
//  WeatherCellTableViewCell.swift
//  rainyshinycloudy
//
//  Created by Murat Kuran on 15/11/2017.
//  Copyright © 2017 Murat Kuran. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var dayName: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!

    func configureCell(forecast: Forecast){
        lowTemp.text = forecast.lowTemp
        highTemp.text = forecast.highTemp
        weatherType.text = forecast.weatherType
        dayName.text = forecast.date
        
        weatherImage.image = UIImage(named: "Clear")
    }
}
