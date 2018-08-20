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
    @IBOutlet weak var MonthLabel: UILabel!
    @IBOutlet weak var DayLabel: UILabel!
    @IBOutlet weak var NameOfDayLabel: UILabel!
    
    var model: DateModel = DateModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Calendar.delegate       = self
        Calendar.dataSource     = self
        
        MonthLabel.text         = "\(getCurrentMonthYear())"
        DayLabel.text           = "\(day)"
        NameOfDayLabel.text     = "\(NameOfDays[weekday])"
        
        GetStartDateDayPosition()
        
        let leftGesture         = UISwipeGestureRecognizer(target: self, action: #selector(self.leftSwiped(_:)))
        leftGesture.direction   = .left
        leftGesture.delegate    = self
        
        let rightGesture        = UISwipeGestureRecognizer(target: self, action: #selector(self.rightSwiped(_:)))
        rightGesture.direction  = .right
        rightGesture.delegate   = self
        
        Calendar.addGestureRecognizer(leftGesture)
        Calendar.addGestureRecognizer(rightGesture)
        
        model.setDummyData()
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
        
        MonthLabel.text = "\(Months[month]) \(year)"
        Calendar.reloadData()
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
        
        MonthLabel.text = "\(getCurrentMonthYear())"
        Calendar.reloadData()
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
            self.performSegue(withIdentifier: "DetailSegue", sender: indexPath)
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
            if indexPath.row / 7 == (DaysInMonths[month] + NumberOfEmptyBox) / 7 {
                cell.ToggleBottomLine()
            }
        case .NEXT:
            currentDay = indexPath.row + 1 - NextNumberOfEmptyBox
            cell.DateLabel.text = "\(currentDay)"
            if indexPath.row / 7 == (DaysInMonths[month] + NextNumberOfEmptyBox) / 7 {
                cell.ToggleBottomLine()
            }
        case .BACK:
            currentDay = indexPath.row + 1 - PreviousNumberOfEmptyBox
            cell.DateLabel.text = "\(currentDay)"
            if indexPath.row / 7 == (DaysInMonths[month] + PreviousNumberOfEmptyBox) / 7 {
                cell.ToggleBottomLine()
            }
        }
        
        if Int(cell.DateLabel.text!)! < 1 {
            cell.cellHide()
        }
        
        // [TODO] 서버 데이터 동기화해서 하이라이트 기능 추가해야 함
        
        // MOCK 모델 데이터
        for (day, value) in model.salaryData {
            if currentDay == day {
                cell.ToggleHistory()
                cell.PriceLabel.text = "\(value)"
            }
        }
        
        if currentDay == model.payDay {
            cell.ToggleHighlight()
            cell.PriceLabel.text = "월급날"
        }
        
        return cell
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width / 7, height: 63)
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
