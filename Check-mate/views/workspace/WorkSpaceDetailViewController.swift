//
//  WorkSpaceDetailViewController.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 7. 1..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class WorkSpaceDetailViewController: UIViewController {

    var workSpace: WorkSpace!
    
    @IBOutlet weak var modifyBtn: UIButton!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var wageLabel: UITextField!
    @IBOutlet weak var probationLabel: UITextField!
    @IBOutlet weak var taxLabel: UITextField!
    @IBOutlet weak var paydayLabel: UITextField!
    @IBOutlet weak var locationLabel: UITextField!
    @IBOutlet weak var scaleLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subscribeToKeyboardNotifications()
        
        nameLabel.text = workSpace.name
        wageLabel.text = String(workSpace.wage)
        probationLabel.text = String(workSpace.probation)
        taxLabel.text = String(workSpace.tax)
        paydayLabel.text = String(workSpace.payDay)
        locationLabel.text = workSpace.address
        scaleLabel.text = (workSpace.fiveState == 0) ? "5인 미만" : "5인 이상"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func backBtnClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func modifyBtnClicked() {
        modifyBtn.isSelected = !modifyBtn.isSelected
        
        [nameLabel, wageLabel, probationLabel, taxLabel, paydayLabel, locationLabel, scaleLabel].forEach {
            $0!.isEnabled = modifyBtn.isSelected
        }
        
        if !modifyBtn.isSelected {
            let name = nameLabel.text ?? ""
            let wage = Int(wageLabel.text ?? "0") ?? 0
            let probation = Int(probationLabel.text ?? "0") ?? 0
            let tax = Double(taxLabel.text ?? "") ?? 0
            let payday = Int(paydayLabel.text ?? "0") ?? 0
            let location = locationLabel.text ?? ""
            let scale = (scaleLabel.text == "5인 미만") ? 0 : 1
            
            workSpace.name = name
            workSpace.wage = wage
            workSpace.probation = probation
            workSpace.tax = tax
            workSpace.payDay = payday
            workSpace.address = location
            workSpace.fiveState = scale
            
            ServerClient.modifyWorkSpace(workSpace: workSpace) { success in
                print("success \(success)")
            }
        }
    }
}
