//
//  WorkSpace.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 9. 3..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import Foundation
import SwiftyJSON

class WorkSpace{
    var id: String
    var userId: String
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
    var wage: Int
    var probation: Int
    var recess: Int
    var recessStatus: Int
    var payDay: Int
    var tax: Double
    var fiveState: Int
    var workingDay: String
    
    init(_ json: JSON) {
        self.id = json["id"].stringValue
        self.userId = json["user_id"].stringValue
        self.name = json["name"].stringValue
        self.address = json["address"].stringValue
        self.latitude = json["latitude"].doubleValue
        self.longitude = json["longitude"].doubleValue
        self.wage = json["hourly_wage"].intValue
        self.probation = json["probation"].intValue
        self.recess = json["recess"].intValue
        self.recessStatus = json["recess_status"].intValue
        self.payDay = json["pay_day"].intValue
        self.tax = json["tax"].doubleValue
        self.fiveState = json["five_state"].intValue
        self.workingDay = json["working_day"].stringValue
    }
}

/*
 "id": "workId0001",
 "user_id": "123456789",
 "name": "맥도날드",
 "address": "서울특별시 성북구 봉선동 1가",
 "latitude": 10.21593,
 "longitude": 43.87534,
 "hourly_wage": 7530,
 "probation": 2,
 "recess": 1,
 "recess_state": 0,
 "pay_day": 25,
 "tax": 3.3,
 "five_state": 0,
 "working_day": "1010100"
 */
