//
//  File.swift
//  BuiltItAssignment
//
//  Created by Raphael on 30/01/18.
//  Copyright © 2018 Raphael. All rights reserved.
//

import Foundation
import ObjectMapper

class Weather: Entity {
    
    var main: String!
    var description: String!
    
    override func mapping(map: Map) {
        main <- map["main"]
        description <- map["description"]
    }
}
