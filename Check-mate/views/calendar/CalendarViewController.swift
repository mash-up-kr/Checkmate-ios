//
//  CalendarViewController.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var Calendar: UICollectionView!
    @IBOutlet weak var MonthLabel: UILabel!
    
    @IBOutlet weak var ToayLabel: UILabel!
    
    
    let Months = ["July", "Febraury", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    let DaysOfMonth = ["M", "T", "W", "T", "F", "S", "S"]
    var DaysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    var currentMonth = String()
    var NumberOfEmptyBox = Int()                // The number of "empty boxes" at the start of the current month
    var NextNumberOfEmptyBox = Int()            // the same with above but with the next month
    var PreviousNumberOfEmptyBox = Int()        // the same with above but with the prev month
    var Direction = 0                           // = 0 if we are at the current month, = 1 if we are in a future month, = -1 if we are in a past month
    var PositionIndex = 0                       // here we will store the above vars of the empty boxes
    
    var LeapYearCounter = year % 4              // its 2 because the next time february has 29 days is in two years (it happen every 4 years)
    
    var dayCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        currentMonth = Months[month]
        MonthLabel.text = "\(currentMonth) \(year)"
        ToayLabel.text = "\(day)"
        
        if weekday == 0 {
            weekday = 7
        }
        
        GetStartDateDayPosition()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    @IBAction func Next(_ sender: Any) {
        switch currentMonth {
        case Months[Months.count - 1]:
            month = 0
            year += 1
            Direction = 1
            
            if LeapYearCounter < 5 {
                LeapYearCounter += 1
            }
            
            if LeapYearCounter == 4 {
                DaysInMonths[1] = 29
            }
            
            if LeapYearCounter == 5 {
                LeapYearCounter = 1
                DaysInMonths[1] = 28
            }
            
            GetStartDateDayPosition()
            
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
            
        default:
            Direction = 1
            
            GetStartDateDayPosition()
            
            month += 1
            
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        }
    }
    
    @IBAction func Back(_ sender: Any) {
        switch currentMonth {
        case Months[0]:
            month = Months.count - 1
            year -= 1
            Direction = -1
            
            if LeapYearCounter > 0 {
                LeapYearCounter -= 1
            }
            
            if LeapYearCounter == 0 {
                DaysInMonths[1] = 29
                LeapYearCounter = 4
            }
            else {
                DaysInMonths[1] = 28
            }
            
            GetStartDateDayPosition()
            
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
            
        default:
            month -= 1
            Direction = -1
            
            GetStartDateDayPosition()
            
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        }
    }
    
    func GetStartDateDayPosition() {
        switch Direction {
        case 0:
            NumberOfEmptyBox = weekday
            dayCounter = day
            
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
            
        case 1...:
            NextNumberOfEmptyBox = (PositionIndex + DaysInMonths[month]) % 7
            PositionIndex = NextNumberOfEmptyBox
            
        case -1:
            PreviousNumberOfEmptyBox = (7 - (DaysInMonths[month] - PositionIndex) % 7)
            if PreviousNumberOfEmptyBox == 7 {
                PreviousNumberOfEmptyBox = 0
            }
            PositionIndex = PreviousNumberOfEmptyBox
            
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Direction {
        case 0:
            return DaysInMonths[month] + NumberOfEmptyBox
        case 1...:
            return DaysInMonths[month] + NextNumberOfEmptyBox
        case -1:
            return DaysInMonths[month] + PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath as IndexPath) as! DateCollectionViewCell
        
        cell.backgroundColor = UIColor.clear
        
        if cell.isHidden {
            cell.isHidden = false
        }
        
        cell.DateLabel.textColor = UIColor.black
        
        switch Direction {
        case 0:
            cell.DateLabel.text = "\(indexPath.row + 1 - NumberOfEmptyBox)"
        case 1:
            cell.DateLabel.text = "\(indexPath.row + 1 - NextNumberOfEmptyBox)"
        case -1:
            cell.DateLabel.text = "\(indexPath.row + 1 - PreviousNumberOfEmptyBox)"
        default:
            fatalError()
        }
        
        if Int(cell.DateLabel.text!)! < 1 {
            cell.isHidden = true
        }
        
        switch indexPath.row {
        case 5, 6, 12, 13, 19, 20, 26, 27, 33, 34:
            if Int(cell.DateLabel.text!)! > 0 {
                cell.DateLabel.textColor = UIColor.red
            }
        default:
            break
        }
        
        if currentMonth == Months[calendar.component(.month, from: date) - 1]
            && year == calendar.component(.year, from: date)
            && day == indexPath.row +  1 - NumberOfEmptyBox {
                cell.PriceLabel.text = "72,000"
        }
        else {
            cell.PriceLabel.text = ""
        }
        
        // [TODO] 알바비 지급일 색상 변경 로직 추가해야함
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath as IndexPath) as! DateCollectionViewCell
        
        self.performSegue(withIdentifier: "DetailSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let destinationVC = segue.destination as? CalendarDetailViewController {
                guard let indexPath = sender as? IndexPath else { return }
                
                guard let cell = Calendar.cellForItem(at: indexPath) as? DateCollectionViewCell else {
                    return
                }
                
                destinationVC.Month = currentMonth
                destinationVC.Day = cell.DateLabel.text!
                destinationVC.Price = cell.PriceLabel.text!
            }
        }
    }
}
