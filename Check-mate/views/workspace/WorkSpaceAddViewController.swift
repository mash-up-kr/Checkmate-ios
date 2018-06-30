//
//  WorkSpaceAddViewController.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 7. 1..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class WorkSpaceAddViewController: UIViewController {

    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var minimumWageBtn: UIButton!
    @IBOutlet weak var probationBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO minimumWageBtn shadow not applied
        let btnList = [locationBtn, minimumWageBtn, probationBtn]
        for btn in btnList {
            if let btn = btn {
                btn.layer.cornerRadius = 5.0
                btn.layer.masksToBounds = false
                btn.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1).cgColor
                btn.layer.shadowRadius = 4
                btn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                btn.layer.shadowOpacity = 1.0
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerBtnClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func backBtnClicked() {
        self.dismiss(animated: true)
    }
}
