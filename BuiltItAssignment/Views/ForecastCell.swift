//
//  ForecastCell.swift
//  BuiltItAssignment
//
//  Created by Raphael on 30/01/18.
//  Copyright © 2018 Raphael. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    @IBOutlet weak var descriptionMainLabel: UILabel!
    @IBOutlet weak var maxTempCelsius: UILabel!
    @IBOutlet weak var minTempCelsius: UILabel!
    @IBOutlet weak var currentTempCelsius: UILabel!
    @IBOutlet weak var foreCastTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fillInformation(dayForeCast: DayForecast) {
        
        let hour = (dayForeCast.fullDate.hour! < 10)  ? "0\(dayForeCast.fullDate.hour!)" : "\(dayForeCast.fullDate.hour!)"
        let minute = (dayForeCast.fullDate.minute! < 10)  ? "0\(dayForeCast.fullDate.minute!)" : "\(dayForeCast.fullDate.minute!)"
        let second = (dayForeCast.fullDate.second! < 10)  ? "0\(dayForeCast.fullDate.second!)" : "\(dayForeCast.fullDate.second!)"
        
        foreCastTime.text = String(format: "%@:%@:%@", hour, minute, second)
        
        if dayForeCast.weather.isEmpty {
            descriptionMainLabel.text = "No weather Information available"
        }else {
            descriptionMainLabel.text = String(format: "%@ - %@", dayForeCast.weather[0].main, dayForeCast.weather[0].description)
        }
        
        maxTempCelsius.text = String(format: "%@ ºC", "\(dayForeCast.temperature.maxTemp!)")
        minTempCelsius.text = String(format: "%@ ºC", "\(dayForeCast.temperature.minTemp!)")
        currentTempCelsius.text = String(format: "%@ ºC", "\(dayForeCast.temperature.currentTemp!)")
    }
}
