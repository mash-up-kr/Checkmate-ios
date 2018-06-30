//
//  HomeViewController.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func monthClicked() {
        let vc = UIStoryboard.instantiate(MonthViewController.self, storyboardName: "MonthViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func calendarClicned() {
        let vc = UIStoryboard.instantiate(CalendarViewController.self, storyboardName: "CalendarViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
