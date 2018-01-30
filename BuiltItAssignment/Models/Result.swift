//
//  Result.swift
//  BuiltItAssignment
//
//  Created by Raphael on 30/01/18.
//  Copyright © 2018 Raphael. All rights reserved.
//

import Foundation
import ObjectMapper

class Result: Entity {
    
    var list: [DayForecast] = []
    
    override func mapping(map: Map) {
        list <- map["list"]
    }
}
