//
//  DayForecast.swift
//  BuiltItAssignment
//
//  Created by Raphael on 30/01/18.
//  Copyright © 2018 Raphael. All rights reserved.
//

import Foundation
import ObjectMapper

class DayForecast: Entity {
    
    var dateText: String!
    var dateTime: Int64!
    var weather: [Weather]!
    var temperature: Temperature!
    var fullDate: DateComponents!
    
    override func mapping(map: Map) {
        dateText <- map["dt_txt"]
        dateTime <- map["dt"]
        weather <- map["weather"]
        temperature <- map["main"]
    }
}
