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
    
    var selectedModel: DetailDateModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false;
        tableView.allowsSelection = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        for _ in 0..<5 {
            let view: DayView = DayView()
            view.setDummyData()
            dayStackView.addArrangedSubview(view)
        }
        
        if let model = selectedModel {
            let currentMonth = "\(Months[model.month])"
            let indexStartOfText = currentMonth.index(currentMonth.startIndex, offsetBy: 2)
            
            MonthLabel.text = "\(currentMonth[...indexStartOfText])"
            weekdayLabel.text = "\(NameOfDays[model.weekday])"
            dayLabel.text = "\(model.day)"
        }
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

internal class DayView: UIView {
    
    private var didUpdateConstraints: Bool = false
    private var WeekDayLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.init(red: 103/255, green: 103/255, blue: 103/255, alpha: 1.0)
        label.textAlignment = .center
        
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 13.0)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        
       return label
    }()
    
    private var circleView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0)
        
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 2
        
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.init(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0).cgColor
        
        view.isHidden = true
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(WeekDayLabel)
        self.addSubview(circleView)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) not been implemented.")
    }
    
    func setDummyData() {
        WeekDayLabel.text = "Tue\n22"
        showHighlight()
    }
    
    func setTitle(text: String) {
        WeekDayLabel.text = text
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            NSLayoutConstraint.activate([
                WeekDayLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0),
                WeekDayLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0),
                WeekDayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                WeekDayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
            
            NSLayoutConstraint.activate([
                circleView.widthAnchor.constraint(equalToConstant: 4.0),
                circleView.heightAnchor.constraint(equalToConstant: 4.0),
                circleView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                circleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 1)
            ])
            
            didUpdateConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func hideHighlight() {
        circleView.isHidden = true
    }
    
    func showHighlight() {
        circleView.isHidden = false
    }
}

internal class TodayMoneyCell: UITableViewCell {
    
    @IBOutlet weak var lblMoney: UILabel!
    
    func setMoney(money: Int) {
        lblMoney.text = String(money) + " won"
    }
    
}

internal class TodayTimeCell: UITableViewCell {
    
    @IBOutlet weak var lblTime: UILabel!
    
}

internal class EtcCell: UITableViewCell {
    
}

extension CalendarDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "todayMoneyCell", for: indexPath) as? TodayMoneyCell else {
                return UITableViewCell()
            }
            
            guard let model = selectedModel else { return UITableViewCell() }
            
            cell.lblMoney.text = "\(model.dailyWage) won"
            
            return cell
        }
        else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "todayTimeCell", for: indexPath) as? TodayTimeCell else {
                return UITableViewCell()
            }
            
            
            
            return cell
        }
        else if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "etcCell", for: indexPath) as? EtcCell else {
                return UITableViewCell()
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 74.0 + 10.0
        }
        else if indexPath.row == 1 {
            return 146.0 + 10.0
        }
        else if indexPath.row == 2 {
            return 247.0 + 10.0
        }
        
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row < 2 {
            let screenSize = UIScreen.main.bounds
            let separatorHeight = CGFloat(10.0)
            
            let additionalSeparator = UIView.init(frame: CGRect(x: 0, y: cell.frame.size.height-separatorHeight, width: screenSize.width, height: separatorHeight))
            additionalSeparator.backgroundColor = UIColor.init(red: 244/250, green: 244/250, blue: 244/250, alpha: 1)
            cell.addSubview(additionalSeparator)
        }
    }
    
}
