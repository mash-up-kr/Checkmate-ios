//
//  WorkRecord.swift
//  Check-mate
//
//  Created by Changmin Kim on 2018. 9. 16..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import Foundation
import SwiftyJSON

class WorkRecord{
    var baseDay : Int
    var totalDay : Int
    var totalMoney : Int
    var totalHour : Int
    var hourlyWage : Int
    
    init(_ json: JSON) {
        self.baseDay = json["base_day"].intValue
        self.totalDay = json["total_day"].intValue
        self.totalMoney = json["total_money"].intValue
        self.totalHour = json["total_hour"].intValue
        self.hourlyWage = json["hourly_wage"].intValue
    }
}
