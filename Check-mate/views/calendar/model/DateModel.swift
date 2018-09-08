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
