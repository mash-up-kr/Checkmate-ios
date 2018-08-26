//
//  CalendarDetailViewController.swift
//  Check-mate
//
//  Created by 김선재 on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class CalendarDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weekdayLabel: UILabel!
    
    @IBOutlet weak var MonthLabel: UILabel!
    
    @IBOutlet weak var dayStackView: UIStackView!
    var DayViews: [DayView] = []
    
    var selectedModel: DetailDateModel = DetailDateModel()
    
    var boolDetailMoney: Bool = false
    var boolDetailTime: Bool = false
    var boolPicture: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false;
        tableView.allowsSelection = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        
        if let centerDate = dateFormatter.date(from: "\(selectedModel.year)-\(selectedModel.month + 1)-\(selectedModel.day)") {
            
            let calendar = Calendar(identifier: .gregorian)
            
            let displayDays: [Date] = [calendar.date(byAdding: .day, value: -2, to: centerDate)!,
                                       calendar.date(byAdding: .day, value: -1, to: centerDate)!,
                                       calendar.date(byAdding: .day, value: 0, to: centerDate)!,
                                       calendar.date(byAdding: .day, value: 1, to: centerDate)!,
                                       calendar.date(byAdding: .day, value: 2, to: centerDate)!
            ]
            
            for i in 0..<5 {
                let view: DayView = DayView()
                
                let weekday = Calendar.current.component(.weekday, from: displayDays[i]) - 1
                let nameOfDay = NameOfDays[weekday]
                
                let indexStartOfText = nameOfDay.index(nameOfDay.startIndex, offsetBy: 2)
                view.setTitle(text: "\(nameOfDay[...indexStartOfText])\n\(Calendar.current.component(.day, from: displayDays[i]))")
                
                dayStackView.addArrangedSubview(view)
            }
        }
        else {
            for _ in 0..<5 {
                let view = DayView()
                view.setDummyData()
                dayStackView.addArrangedSubview(view)
            }
        }
        
        let currentMonth = "\(Months[selectedModel.month])"
        let indexStartOfText = currentMonth.index(currentMonth.startIndex, offsetBy: 2)
        
        MonthLabel.text = "\(currentMonth[...indexStartOfText])"
        weekdayLabel.text = "\(NameOfDays[selectedModel.weekday])"
        dayLabel.text = "\(selectedModel.day)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension Date {
    var dayBeforeYesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: noon)!
    }
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var today: Date {
        return Calendar.current.date(byAdding: .day, value: 0, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var dayAfterTomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 2, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    var isLastDayOfMonth: Bool {
        return Calendar.current.component(.month, from: tomorrow) != month
    }
}

extension CalendarDetailViewController: TodayMoneyCellDelegate {
    func openPressed(_ cell: TodayMoneyCell) {
        boolDetailMoney = true
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}

extension CalendarDetailViewController: DetailMoneyCellDelegate {
    func closedPressed(_ cell: DetailMoneyCell) {
        boolDetailMoney = false
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        
        if let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TodayMoneyCell {
            cell.showButton()
        }
    }
}

extension CalendarDetailViewController: TodayTimeCellDelegate {
    func openPressed(_ cell: TodayTimeCell) {
        boolDetailTime = true
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}

extension CalendarDetailViewController: DetailTimeCellDelegate {
    func closedPressed(_ cell: DetailTimeCell) {
        boolDetailTime = false
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        
        if let cell = self.tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? TodayTimeCell {
            cell.showButton()
        }
    }
}

extension CalendarDetailViewController: PictureCellDelegate {
    func buttonPressed(_ pictureCell: PictureCell) {
        boolPicture = !boolPicture
        
        if boolPicture {
            pictureCell.showCollectionView()
        }
        else {
            pictureCell.hideCollectionView()
        }
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}

extension CalendarDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "todayMoneyCell", for: indexPath) as? TodayMoneyCell else {
                return UITableViewCell()
            }
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            
            if let strDailyWage = numberFormatter.string(from: NSNumber(value: selectedModel.dailyWage)) {
                cell.lblMoney.text = "\(strDailyWage) won"
            }
            else {
                cell.lblMoney.text = "\(selectedModel.dailyWage) won"
            }
            
            cell.delegate = self
            // cell.showSeparator()
            
            return cell
        }
        else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailMoneyCell", for: indexPath) as? DetailMoneyCell else {
                return UITableViewCell()
            }

            cell.setHourlyWage(selectedModel.hourlyWage)
            cell.setHour(selectedModel.workingHour)
            cell.delegate = self
            
//            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
//            cell.layer.shadowColor = UIColor.black.cgColor
//            cell.layer.shadowRadius = 5
//
//            cell.layer.shadowOpacity = 0.40
//            cell.layer.masksToBounds = false;
//            cell.clipsToBounds = false;
            
            return cell
        }
        else if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "todayTimeCell", for: indexPath) as? TodayTimeCell else {
                return UITableViewCell()
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "h a"
            
            if selectedModel.times.count > 0 {
                let firstHour: String = formatter.string(from: selectedModel.times.first!)
                let lastHour: String = formatter.string(from: selectedModel.times.last!)
                
                cell.lblTime.text = "\(firstHour) - \(lastHour)"
            }
            else {
                cell.lblTime.text = "None"
            }
            
            cell.delegate = self
            // cell.showSeparator()
            
            return cell
        }
        else if indexPath.row == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailTimeCell", for: indexPath) as? DetailTimeCell else {
                return UITableViewCell()
            }
            
            cell.setTimes(selectedModel.times)
            
            cell.delegate = self
            
//            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
//            cell.layer.shadowColor = UIColor.black.cgColor
//            cell.layer.shadowRadius = 5
//
//            cell.layer.shadowOpacity = 0.40
//            cell.layer.masksToBounds = false;
//            cell.clipsToBounds = false;
            
            return cell
        }
        else if indexPath.row == 4 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "pictureCell", for: indexPath) as? PictureCell else {
                return UITableViewCell()
            }
            
            cell.setImages(images: selectedModel.pictures)
            
            cell.showSeparator()
            cell.delegate = self
            
            return cell
        }
        else if indexPath.row == 5 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "etcCell", for: indexPath) as? EtcCell else {
                return UITableViewCell()
            }
            
            cell.setExtras(selectedModel.extraPaies)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 88.0
        }
        else if indexPath.row == 1 {
            guard let cell = self.tableView.cellForRow(at: indexPath) as? DetailMoneyCell else {
                return 10
            }
            
            if boolDetailMoney {
                
                return 101
            }
            else {
                
                return 10
            }
        }
        else if indexPath.row == 2 {
            return 146.0
        }
        else if indexPath.row == 3 {
            if boolDetailTime {
                return 204.0
            }
            else {
                return 10
            }
        }
        else if indexPath.row == 4 {
            if boolPicture {
                return 223.0 + 10.0
            }
            else {
                return 83 + 10.0
            }
        }
        else if indexPath.row == 5 {
            return 247.0
        }
        
        return 60.0
    }
}
