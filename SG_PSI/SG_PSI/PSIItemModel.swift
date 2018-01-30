//
//  PSIItemModel.swift
//  SG_PSI
//
//  Created by v.vajiravelu on 30/1/18.
//  Copyright © 2018 vas. All rights reserved.
//

import Foundation
import SwiftyJSON

class PSIReadings {
    
    var south: String?
    var north: String?
    var east: String?
    var west: String?
    var central : String?
    var national : String?
    
    init(_ object: JSON) {
        
        south = object["south"].stringValue
        north = object["north"].stringValue
        east = object["east"].stringValue
        west = object["west"].stringValue
        central = object["central"].stringValue
        national = object["national"].stringValue

    }
}
