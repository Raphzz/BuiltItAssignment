//
//  Entity.swift
//  BuiltItAssignment
//
//  Created by Raphael on 30/01/18.
//  Copyright © 2018 Raphael. All rights reserved.
//

import Foundation
import ObjectMapper

class Entity: Mappable {
    
    required init() {
        
    }
    
    required convenience init?(map: Map) {
        self.init()
        
    }
    
    func mapping(map: Map) {
        fatalError("Mapping function should be implemented.")
    }
}

