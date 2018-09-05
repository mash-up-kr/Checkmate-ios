//
//  CalendarVars.swift
//  Check-mate
//
//  Created by 김선재 on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import Foundation

// Literal Strings
let Months                          = ["January", "Febraury", "March", "April", "May",
                                       "June", "July", "August", "September", "October",
                                       "November", "December"]
let NameOfDays                      = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday",
                                       "Saturday"]

// Current info
let date                            = Date()
let calendar                        = Calendar.current

var DaysInMonths                    = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

var day                             = calendar.component(.day, from: date)
var weekday                         = calendar.component(.weekday, from: date) - 1
var month                           = calendar.component(.month, from: date) - 1
var year                            = calendar.component(.year, from: date)

// The number of "empty boxes" at the start of the current month
var NumberOfEmptyBox                = Int()

// the same with above but with the next month
var NextNumberOfEmptyBox            = Int()

// the same with above but with the prev month
var PreviousNumberOfEmptyBox        = Int()

// = 0 if we are at the current month, = 1 if we are in a future month, = -1 if we are in a past month
enum enumDirection: Int {
    case BACK                       = -1
    case CURRENT                    = 0
    case NEXT                       = 1
}
var Direction: enumDirection        = .CURRENT

// here we will store the above vars of the empty boxes
var PositionIndex                   = 0

// its 2 because the next time february has 29 days is in two years (it happen every 4 years)
var LeapYearCounter                 = year % 4

func GetStartDateDayPosition() {
    switch Direction {
    case .CURRENT:
        NumberOfEmptyBox = weekday + 1
        var dayCounter = day
        
        while dayCounter > 0 {
            NumberOfEmptyBox = NumberOfEmptyBox - 1
            dayCounter -= 1
            if NumberOfEmptyBox == 0 {
                NumberOfEmptyBox = 7
            }
        }
        if NumberOfEmptyBox == 7 {
            NumberOfEmptyBox = 0
        }
        
        PositionIndex = NumberOfEmptyBox
        
    case .NEXT:
        NextNumberOfEmptyBox = (PositionIndex + DaysInMonths[month]) % 7
        PositionIndex = NextNumberOfEmptyBox
        
    case .BACK:
        PreviousNumberOfEmptyBox = (7 - (DaysInMonths[month] - PositionIndex) % 7)
        if PreviousNumberOfEmptyBox == 7 {
            PreviousNumberOfEmptyBox = 0
        }
        PositionIndex = PreviousNumberOfEmptyBox
    }
}

func GetLeapYearCounter(_ dir: enumDirection) {
    switch dir {
    case .BACK:
        if LeapYearCounter > 0 {
            LeapYearCounter -= 1
        }
        
        if LeapYearCounter == 0 {
            DaysInMonths[1] = 29
            LeapYearCounter = 4
        } else {
            DaysInMonths[1] = 28
        }
    case .NEXT:
        if LeapYearCounter < 5 {
            LeapYearCounter += 1
        }
        
        if LeapYearCounter == 4 {
            DaysInMonths[1] = 29
        } else if LeapYearCounter == 5 {
            LeapYearCounter = 1
            DaysInMonths[1] = 28
        }
    default:
        fatalError("fatar Error in GetLeapYearCounter()")
    }
}


func getCurrentMonth() -> String {
    return "\(Months[month])"
}
