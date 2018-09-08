//
//  DateModel.swift
//  Check-mate
//
//  Created by 김선재 on 2018. 8. 5..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import Foundation
import SwiftyJSON

class DateModel {
    var payDay: Int = Int()
    var salaryData: [Int: Int] = Dictionary()
    
    init() { }
    
    init(_ json: JSON) {
        var salaryData: [Int: Int] = Dictionary()
        
        setPayDay(payDay: 25)
        
        for inner in json.arrayValue {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = TimeZone.current
            
            if let date = dateFormatter.date(from: inner["date"].stringValue) {
                salaryData[date.day] = inner["daily_wage"].intValue
            }
        }
        
        setSalaryData(salaryData: salaryData)
    }
    
    func setPayDay(payDay: Int) {
        self.payDay = payDay
    }
    
    func setSalaryData(salaryData: [Int: Int]) {
        self.salaryData = salaryData
    }
    
    func setDummyData() {
        setPayDay(payDay: 25)
        setSalaryData(salaryData: [1: 72000, 2: 75040, 8: 72000, 9: 75040])
    }
}
