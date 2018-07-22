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
    
    var selectedMonth: Int!
    var selectedDay: Int!
    var selectedPrice: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false;
        tableView.allowsSelection = false
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

internal class TodayMoneyCell: UITableViewCell {
    
    @IBOutlet weak var lblMoney: UILabel!
    
}

internal class TodayTimeCell: UITableViewCell {
    
    @IBOutlet weak var lblTime: UILabel!
    
}

internal class EtcCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle1: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var lblTitle3: UILabel!
    @IBOutlet weak var lblTitle4: UILabel!
    
    @IBOutlet weak var lblPay1: UILabel!
    @IBOutlet weak var lblPay2: UILabel!
    @IBOutlet weak var lblPay3: UILabel!
    @IBOutlet weak var lblPay4: UILabel!
    
    
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
            
            cell.lblMoney.text = "\(selectedPrice) won"
            
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
