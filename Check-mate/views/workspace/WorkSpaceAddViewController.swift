//
//  WorkSpaceAddViewController.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 7. 1..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class WorkSpaceAddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnClicked() {
        self.navigationController?.dismiss(animated: true)
    }
}
