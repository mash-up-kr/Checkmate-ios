//
//  DetailDateModel.swift
//  Check-mate
//
//  Created by 김선재 on 2018. 8. 5..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import Foundation

enum ExtraPayType {
    case night
    case holiday
    case overtime
    
    func description() -> String {
        switch self {
        case .night:
            return "야간수당"
        case .holiday:
            return "주휴수당"
        case .overtime:
            return "초과근무수당"
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
    
    var time: [Date] = []
    
    var extraPay: [ExtraPay] = []
    
    init() {
        
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
    
    func setTimes(time: [Date]) {
        self.time = time
    }
    
    func setExtraPay(extraPay: [ExtraPay]) {
        self.extraPay = extraPay
    }
    
    func pushExtraPay(type: ExtraPayType, value: Int) {
        self.extraPay.append(ExtraPay(type: type, value: value))
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
        
        setTimes(time: times)
        
        pushExtraPay(type: .night, value: 30000)
        pushExtraPay(type: .holiday, value: 0)
        pushExtraPay(type: .overtime, value: 0)
    }
}
