//
//  CalendarViewController.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var Calendar: UICollectionView!
    @IBOutlet weak var YearLabel: UILabel!
    @IBOutlet weak var MonthLabel: UILabel!
    @IBOutlet weak var DayLabel: UILabel!
    @IBOutlet weak var NameOfDayLabel: UILabel!
    
    @IBOutlet weak var CircleView: UIView!
    
    var model: DateModel = DateModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ServerClient.getCalendarMain(year: year, month: month + 1, callback: { (code: Int, dateModel: DateModel) -> Void in
            
            self.model = dateModel
            self.Calendar.reloadData()
        })
        
        Calendar.delegate = self
        Calendar.dataSource = self
        
        YearLabel.text          = "\(year)"
        MonthLabel.text         = "\(getCurrentMonth())"
        DayLabel.text           = "\(day)"
        NameOfDayLabel.text     = "\(NameOfDays[weekday])"
        
        CircleView.layer.cornerRadius = CircleView.bounds.size.height / 2
        
        GetStartDateDayPosition()
        
        let leftGesture         = UISwipeGestureRecognizer(target: self, action: #selector(self.leftSwiped(_:)))
        leftGesture.direction   = .left
        leftGesture.delegate    = self
        
        let rightGesture        = UISwipeGestureRecognizer(target: self, action: #selector(self.rightSwiped(_:)))
        rightGesture.direction  = .right
        rightGesture.delegate   = self
        
        Calendar.addGestureRecognizer(leftGesture)
        Calendar.addGestureRecognizer(rightGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
}

// Button Actions & Segue Control
extension CalendarViewController {
    @IBAction func Next(_ sender: Any?) {
        Direction = .NEXT
        
        switch month {
        case Months.count - 1:
            month = 0
            year += 1
            
            GetLeapYearCounter(Direction)
            GetStartDateDayPosition()
        default:
            GetStartDateDayPosition()
            
            month += 1
        }
        
        YearLabel.text = "\(year)"
        MonthLabel.text = "\(getCurrentMonth())"
        
        ServerClient.getCalendarMain(year: year, month: month + 1, callback: { (code: Int, dateModel: DateModel) -> Void in
            
            self.model = dateModel
            self.Calendar.reloadData()
        })
    }
    
    @IBAction func Back(_ sender: Any?) {
        Direction = .BACK
        
        switch month {
        case 0:
            month = Months.count - 1
            year -= 1
            
            GetLeapYearCounter(Direction)
            GetStartDateDayPosition()
        default:
            month -= 1
            
            GetStartDateDayPosition()
        }
        
        YearLabel.text = "\(year)"
        MonthLabel.text = "\(getCurrentMonth())"
        
        ServerClient.getCalendarMain(year: year, month: month + 1, callback: { (code: Int, dateModel: DateModel) -> Void in
            
            self.model = dateModel
            self.Calendar.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? CalendarDetailViewController {
            guard let indexPath = sender as? IndexPath else {
                return
            }
            
            guard let cell = Calendar.cellForItem(at: indexPath) as? DateCollectionViewCell else {
                return
            }
            
            let detail: DetailDateModel = DetailDateModel()
            destinationVC.selectedModel = detail
            
            detail.year = year;
            detail.month = month;
            detail.weekday = indexPath.row % 7
            
            if let day = Int(cell.DateLabel.text!) {
                detail.day = day
            }
            else {
                return
            }
            
            if !cell.CircleView.isHidden {
                detail.setDummyData()
            }
        }
    }
}

extension CalendarViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = Calendar.cellForItem(at: indexPath) as? DateCollectionViewCell else {
            return
        }
        
        if cell.DateLabel.isHidden {
            return
        }
        else {
            if cell.isHistory
            {
                self.performSegue(withIdentifier: "DetailSegue", sender: indexPath)
            }
        }
    }
}

extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Direction {
        case .CURRENT:
            return DaysInMonths[month] + NumberOfEmptyBox
        case .NEXT:
            return DaysInMonths[month] + NextNumberOfEmptyBox
        case .BACK:
            return DaysInMonths[month] + PreviousNumberOfEmptyBox
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath as IndexPath) as! DateCollectionViewCell
        
        let currentDay: Int
        
        cell.cellClear()
        
        switch Direction {
        case .CURRENT:
            currentDay = indexPath.row + 1 - NumberOfEmptyBox
            cell.DateLabel.text = "\(currentDay)"
        case .NEXT:
            currentDay = indexPath.row + 1 - NextNumberOfEmptyBox
            cell.DateLabel.text = "\(currentDay)"
        case .BACK:
            currentDay = indexPath.row + 1 - PreviousNumberOfEmptyBox
            cell.DateLabel.text = "\(currentDay)"
        }
        
        if Int(cell.DateLabel.text!)! < 1 {
            cell.cellHide()
        }
        
        for (day, value) in model.salaryData {
            if currentDay == day {
                cell.ToggleHighlight()
                cell.ToggleHistory()
                cell.PriceLabel.text = "\(value)"
            }
        }
        
        if currentDay == model.payDay {
            cell.TogglePayDay()
            cell.PriceLabel.text = "🎉"
        }
        
        return cell
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Calendar.bounds.size.width / 7, height: 67)
    }
}

extension CalendarViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func leftSwiped(_ sender: UIGestureRecognizer) {
        self.Next(nil)
    }
    
    @objc func rightSwiped(_ sender: UIGestureRecognizer) {
        self.Back(nil)
    }
}
