//
//  Day.swift
//  BuiltItAssignment
//
//  Created by Raphael on 30/01/18.
//  Copyright © 2018 Raphael. All rights reserved.
//

import Foundation

class Day {
    
    var dayForecasts: [DayForecast] = []
    var fullDate: DateComponents!
    
    init(fullDate: DateComponents) {
        self.fullDate = fullDate
    }
}
