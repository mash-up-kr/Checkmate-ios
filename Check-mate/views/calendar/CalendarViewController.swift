//
//  CalendarViewController.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var Calendar: UICollectionView!
    @IBOutlet weak var MonthLabel: UILabel!
    @IBOutlet weak var DayLabel: UILabel!
    @IBOutlet weak var NameOfDayLabel: UILabel!
        
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
        DayLabel.text = "\(day)"
        NameOfDayLabel.text = "\(NameOfDays[weekday])"
        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width / 7, height: 63)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath as IndexPath) as! DateCollectionViewCell
    
       cell.cellClear()
        
        switch Direction {
        case 0:
            cell.DateLabel.text = "\(indexPath.row + 1 - NumberOfEmptyBox)"
            if indexPath.row / 7 == (DaysInMonths[month] + NumberOfEmptyBox) / 7 {
                cell.ToggleBottomLine()
            }
        case 1:
            cell.DateLabel.text = "\(indexPath.row + 1 - NextNumberOfEmptyBox)"
            if indexPath.row / 7 == (DaysInMonths[month] + NextNumberOfEmptyBox) / 7 {
                cell.ToggleBottomLine()
            }
        case -1:
            cell.DateLabel.text = "\(indexPath.row + 1 - PreviousNumberOfEmptyBox)"
            if indexPath.row / 7 == (DaysInMonths[month] + PreviousNumberOfEmptyBox) / 7 {
                cell.ToggleBottomLine()
            }
        default:
            fatalError()
        }
        
        if Int(cell.DateLabel.text!)! < 1 {
            cell.cellHide()
        }
        
        switch indexPath.row {
        case 5, 6, 12, 13, 19, 20:
            cell.ToggleHistory()
            cell.PriceLabel.text = "72,000"
        case 27:
            cell.ToggleHighlight()
            cell.PriceLabel.text = "월급날"
        default:
            break
        }
        
        // [TODO] 알바비 지급일 색상 변경 로직 추가해야함
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
