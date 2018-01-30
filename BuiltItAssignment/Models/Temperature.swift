//
//  Temperature.swift
//  BuiltItAssignment
//
//  Created by Raphael on 30/01/18.
//  Copyright © 2018 Raphael. All rights reserved.
//

import Foundation
import ObjectMapper

class Temperature : Entity {
    
    var currentTemp: Double!
    var maxTemp: Double!
    var minTemp: Double!
    
    override func mapping(map: Map) {
        currentTemp <- map["temp"]
        maxTemp <- map["temp_max"]
        minTemp <- map["temp_min"]
    }
}
