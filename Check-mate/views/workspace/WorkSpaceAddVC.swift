//
//  WorkSpaceAddVC01.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 8. 4..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class WorkSpaceAddVC: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var statusStackView: UIStackView!
    
    var nameIVC: WorkSpaceAddNameIVC!
    var salaryIVC: WorkSpaceAddSalaryIVC!
    var probationIVC: WorkSpaceAddProbationIVC!
    var restIVC: WorkSpaceAddRestIVC!
    var taxIVC: WorkSpaceAddTAXIVC!
    var paydayIVC: WorkSpaceAddPaydayIVC!
    var scaleIVC: WorkSpaceAddScaleIVC!
    
    var nowIndex: Int = 0
    var color1: UIColor!
    var color2: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subscribeToKeyboardNotifications()
        
        self.color1 = statusStackView.subviews[0].backgroundColor
        self.color2 = statusStackView.subviews[1].backgroundColor
        
        update()
    }
    
    @IBAction func prevBtnClicked() {
        if nowIndex > 0 {
            nowIndex -= 1
            update()
        }
    }
    
    @IBAction func nextBtnClicked() {
        if nowIndex < statusStackView.subviews.count - 1 {
            nowIndex += 1
            update()
        }
    }
    
    func update() {
        let tmp = CGPoint(x: CGFloat(nowIndex) * scrollView.frame.width, y: 0.0)
        scrollView.setContentOffset(tmp, animated: true)
        
        for (i, view) in statusStackView.subviews.enumerated() {
            guard let dot = view as? GraphicView else {
                return
            }
            
            dot.backgroundColor = (i <= nowIndex) ? color1 : color2
        }
        
        switch nowIndex {
        case 0:
            nameIVC.textField.becomeFirstResponder()
        case 1:
            salaryIVC.textField.becomeFirstResponder()
        case 2:
            probationIVC.textField.becomeFirstResponder()
        case 3:
            restIVC.textField.becomeFirstResponder()
        case 4:
            taxIVC.textField.becomeFirstResponder()
        case 5:
            paydayIVC.textField.becomeFirstResponder()
        case 6:
            scaleIVC.textField.becomeFirstResponder()
        default:
            return
        }
    }
    
    @IBAction func backBtnClicked() {
        self.dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination
        
        switch vc {
        case is WorkSpaceAddNameIVC:
            nameIVC = vc as! WorkSpaceAddNameIVC
        case is WorkSpaceAddSalaryIVC:
            salaryIVC = vc as! WorkSpaceAddSalaryIVC
        case is WorkSpaceAddPaydayIVC:
            paydayIVC = vc as! WorkSpaceAddPaydayIVC
        case is WorkSpaceAddProbationIVC:
            probationIVC = vc as! WorkSpaceAddProbationIVC
        case is WorkSpaceAddRestIVC:
            restIVC = vc as! WorkSpaceAddRestIVC
        case is WorkSpaceAddTAXIVC:
            taxIVC = vc as! WorkSpaceAddTAXIVC
        case is WorkSpaceAddScaleIVC:
            scaleIVC = vc as! WorkSpaceAddScaleIVC
        default:
            return
        }
    }
}

class WorkSpaceAddNameIVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
}

class WorkSpaceAddSalaryIVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
}

class WorkSpaceAddPaydayIVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
}

class WorkSpaceAddProbationIVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
}

class WorkSpaceAddRestIVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
}

class WorkSpaceAddTAXIVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
}

class WorkSpaceAddScaleIVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
}
