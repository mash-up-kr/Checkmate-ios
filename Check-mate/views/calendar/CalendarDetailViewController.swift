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
    
    var Month = String()
    var Day = String()
    var Price = String()
    
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

internal class TotalMoneyHeaderCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel!
    
}

internal class TotalMoneyCell: UITableViewCell {
    
    @IBOutlet weak var lblTotalMoney: UILabel!
    
}

extension CalendarDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "lblTotalMoneyHeader", for: indexPath) as? TotalMoneyHeaderCell else {
                return UITableViewCell()
            }
            
            return cell
        }
        else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "lblMoney", for: indexPath) as? TotalMoneyCell else {
                return UITableViewCell()
            }
            
            cell.lblTotalMoney.text = "\(Price) 원"
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80.0
        }
        
        return 60.0
    }
    
}
