//
//  DetailDateModel.swift
//  Check-mate
//
//  Created by 김선재 on 2018. 8. 5..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

enum ExtraPayType {
    case night
    case holiday
    case overtime
    case week
    
    func description() -> String {
        switch self {
        case .night:
            return "야간 수당"
        case .holiday:
            return "휴일 수당"
        case .overtime:
            return "연장 수당"
        case .week:
            return "주휴 수당"
        }
    }
}

struct ExtraPay {
    var type: ExtraPayType  = .holiday  // default
    var value: Int          = Int()
    
    init() {
        // empty
    }
    
    init(type: ExtraPayType, value: Int) {
        self.type   = type
        self.value  = value
    }
}

class DetailDateModel {
    var year: Int = Int()
    var month: Int = Int()
    var weekday: Int = Int()
    var day: Int = Int()
    
    var dailyWage: Int = Int()
    var hourlyWage: Int = Int()
    var workingHour: Int = Int()
    
    var times: [Date] = []
    
    var extraPaies: [ExtraPay] = []
    
    var pictures: [UIImage] = []
    
    init() {
        
    }
    
    init(_ json: JSON) {
        var times: [Date] = []
        
        self.dailyWage = json["daily_wage"].intValue
        self.hourlyWage = json["hourly_wage"].intValue
        self.workingHour = json["working_hour"].intValue
        
        for inner in json["time"].arrayValue {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yy-MM-dd HH:mm:ss"
            dateFormatter.timeZone = TimeZone.current
            
            if let date = dateFormatter.date(from: inner["timestamp"].stringValue) {
                times.append(date)
            }
        }
        
        setTimes(times: times)
        
        pushExtraPay(type: .night, value: json["night_allowance"].intValue)
        pushExtraPay(type: .holiday, value: json["holiday_allowance"].intValue)
        pushExtraPay(type: .week, value: json["weekly_holiday_allowance"].intValue)
        pushExtraPay(type: .overtime, value: json["overtime_allowance"].intValue)
    }
    
    func setDailyWage(dailyWage: Int) {
        self.dailyWage = dailyWage
    }
    
    func setHourlyWage(hourlyWage: Int) {
        self.hourlyWage = hourlyWage
    }
    
    func setWorkingHour(workingHour: Int) {
        self.workingHour = workingHour
    }
    
    func setTimes(times: [Date]) {
        self.times = times
    }
    
    func setExtraPaies(extraPaies: [ExtraPay]) {
        self.extraPaies = extraPaies
    }
    
    func pushExtraPay(type: ExtraPayType, value: Int) {
        self.extraPaies.append(ExtraPay(type: type, value: value))
    }
    
    func setPictures(pictures: [UIImage]) {
        self.pictures = pictures
    }
    
    func pushPicture(picture: UIImage) {
        self.pictures.append(picture)
    }
    
    func setDummyData() {
        setDailyWage(dailyWage: 80000)
        setHourlyWage(hourlyWage: 7350)
        setWorkingHour(workingHour: 5)
        
        var times: [Date] = []
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        times.append(formatter.date(from: "\(year)/\(month)/\(day) 11:00")!)
        times.append(formatter.date(from: "\(year)/\(month)/\(day) 13:00")!)
        times.append(formatter.date(from: "\(year)/\(month)/\(day) 14:00")!)
        times.append(formatter.date(from: "\(year)/\(month)/\(day) 17:00")!)
        
        setTimes(times: times)
        
        pushExtraPay(type: .night, value: 0)
        pushExtraPay(type: .holiday, value: 0)
        pushExtraPay(type: .week, value: 0)
        pushExtraPay(type: .overtime, value: 0)
        
        if let dummyIcon = UIImage(named: "dummyIcon") {
            pushPicture(picture: dummyIcon)
            pushPicture(picture: dummyIcon)
            pushPicture(picture: dummyIcon)
            pushPicture(picture: dummyIcon)
            pushPicture(picture: dummyIcon)
        }
    }
}
