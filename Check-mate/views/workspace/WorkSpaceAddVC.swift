//
//  WorkSpaceAddVC01.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 8. 4..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class WorkSpaceAddVC: UIViewController {
    @IBOutlet weak var pageIndicator: PageIndicator!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var warningLable: UILabel!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var bottomBtnBar: UIStackView!
    @IBOutlet weak var bottomBtnBarLeading: NSLayoutConstraint!
    
    var nameIVC: WorkSpaceAddNameIVC!
    var salaryIVC: WorkSpaceAddSalaryIVC!
    var probationIVC: WorkSpaceAddProbationIVC!
    var restIVC: WorkSpaceAddRestIVC!
    var paydayIVC: WorkSpaceAddPaydayIVC!
    var taxIVC: WorkSpaceAddTAXIVC!
    var scaleIVC: WorkSpaceAddScaleIVC!
    
    var totalIndex: Int = 0
    var nowIndex: Int = 0
    var nextable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subscribeToKeyboardNotifications()
        
        self.totalIndex = scrollView.subviews[0].subviews.count
        self.pageIndicator.initiate(totalPage: totalIndex)
        
        nameIVC.textChangeCallback = { name in
            self.nextable = name != ""
            self.updateUI()
        }
        
        salaryIVC.textChangeCallback = { salary in
            self.nextable = salary != ""
            self.updateUI()
        }
        
        paydayIVC.textChangeCallback = { payday in
            self.nextable = payday != ""
            self.updateUI()
        }
        
        taxIVC.btnClickCallback = { title in
            self.nextable = true
            self.updateUI()
        }
        
        scaleIVC.btnClickCallback = { title in
            self.nextable = true
            self.updateUI()
        }
        
        changePage()
    }
    
    @IBAction func prevBtnClicked() {
        if nowIndex - 1 >= 0 {
            nowIndex -= 1
            pageIndicator.prev()
            changePage()
        }
    }
    
    @IBAction func nextBtnClicked() {
        if nowIndex + 1 < totalIndex {
            nowIndex += 1
            pageIndicator.next()
            changePage()
        }
        
        if nowIndex + 1 == totalIndex {
            finish()
        }
    }
    
    private func changePage() {
        let tmp = CGPoint(x: CGFloat(nowIndex) * scrollView.frame.width, y: 0.0)
        scrollView.setContentOffset(tmp, animated: true)
        
        switch nowIndex {
        case 0:
            nameIVC.textField.becomeFirstResponder()
            nextable = (nameIVC.textField.text ?? "") != ""
        case 1:
            salaryIVC.textField.becomeFirstResponder()
            nextable = (salaryIVC.textField.text ?? "") != ""
        case 2:
            self.view.endEditing(true)
            nextable = true
        case 3:
            restIVC.textField.becomeFirstResponder()
            nextable = true
        case 4:
            paydayIVC.textField.becomeFirstResponder()
            nextable = (paydayIVC.textField.text ?? "") != ""
        case 5:
            self.view.endEditing(true)
            nextable = (taxIVC.btn.title(for: .normal) ?? "") != ""
        case 6:
            self.view.endEditing(true)
            nextable = (scaleIVC.btn.title(for: .normal) ?? "") != ""
        case 7:
            self.view.endEditing(true)
            nextable = true
        default:
            return
        }
        
        bottomBtnBarLeading.constant = (nowIndex == 0) ? -self.view.frame.width : 0
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        })
        
        updateUI()
    }
    
    private func updateUI() {
        nextBtn.backgroundColor = nextable ? UIColor.blue1 : UIColor.grey204
        nextBtn.isEnabled = nextable
    }
    
    private func finish() {
        let name = nameIVC.textField.text ?? ""
        let address = "address"
        let latitude = 12.345
        let longitude = 23.456
        let hourlyWage = Int(salaryIVC.textField.text ?? "0")
        let probation = Int(probationIVC.textField.text ?? "0")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination
        
        switch vc {
        case is WorkSpaceAddNameIVC:
            nameIVC = vc as! WorkSpaceAddNameIVC
        case is WorkSpaceAddSalaryIVC:
            salaryIVC = vc as! WorkSpaceAddSalaryIVC
        case is WorkSpaceAddProbationIVC:
            probationIVC = vc as! WorkSpaceAddProbationIVC
        case is WorkSpaceAddRestIVC:
            restIVC = vc as! WorkSpaceAddRestIVC
        case is WorkSpaceAddPaydayIVC:
            paydayIVC = vc as! WorkSpaceAddPaydayIVC
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
    var textChangeCallback: ((String) -> Void)?
    
    @IBAction func textDidChange() {
        textChangeCallback?(textField.text ?? "")
    }
}

class WorkSpaceAddSalaryIVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
    var textChangeCallback: ((String) -> Void)?
    
    @IBAction func textDidChange() {
        textChangeCallback?(textField.text ?? "")
    }
}

class WorkSpaceAddProbationIVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var bar2: UIView!
    let EXIST = "있습니다"
    let NOTEXIST = "없습니다"
    var probationExist = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func btn1Clicked() {
        self.showListAlertView(title: "",
                               content: "해당되는 항목을 골라주세요",
                               items: [EXIST, NOTEXIST]) { item in
            guard let selected = item else { return }
            self.probationExist = selected == self.EXIST
            self.updateUI()
        }
    }
    
    private func updateUI() {
        self.button.setTitle(probationExist ? EXIST : NOTEXIST, for: .normal)
        
        bar2.backgroundColor = probationExist ? UIColor.white : UIColor.grey243
        button2.setTitleColor(probationExist ? UIColor.grey85 : UIColor.grey136, for: .normal)
        textField.isEnabled = probationExist
        textField.isHidden = !probationExist
        
        if probationExist {
            textField.becomeFirstResponder()
        }
    }
}

class WorkSpaceAddRestIVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var yuBtn: UIButton!
    @IBOutlet weak var muBtn: UIButton!
    let selectedBackgroundColor = UIColor.blue1
    let selectedTextColor = UIColor.white
    let deselectedBackgroundColor = UIColor.white
    let deselectedTextColor = UIColor.grey136
    var isYuSelected: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func textFieldDidChange() {
        guard let text = textField.text else { return }
        
        if text == "" || Int(text) == 0 {
            isYuSelected = nil
        } else {
            isYuSelected = false
        }
        
        updateUI()
    }
    
    @IBAction func btnClicked(_ btn: UIButton) {
        isYuSelected = btn == yuBtn
        updateUI()
    }
    
    private func updateUI() {
        guard let yu = isYuSelected else {
            yuBtn.backgroundColor = UIColor.grey243
            muBtn.backgroundColor = UIColor.grey243
            yuBtn.setTitleColor(deselectedTextColor, for: .normal)
            muBtn.setTitleColor(deselectedTextColor, for: .normal)
            yuBtn.isEnabled = false
            muBtn.isEnabled = false
            return
        }
        
        yuBtn.backgroundColor = yu ? selectedBackgroundColor : deselectedBackgroundColor
        muBtn.backgroundColor = yu ? deselectedBackgroundColor : selectedBackgroundColor
        yuBtn.setTitleColor(yu ? selectedTextColor : deselectedTextColor, for: .normal)
        muBtn.setTitleColor(yu ? deselectedTextColor : selectedTextColor, for: .normal)
        yuBtn.isEnabled = true
        muBtn.isEnabled = true
    }
}

class WorkSpaceAddPaydayIVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
    var textChangeCallback: ((String) -> Void)?
    
    @IBAction func textDidChange() {
        textChangeCallback?(textField.text ?? "")
    }
}

class WorkSpaceAddTAXIVC: UIViewController {
    @IBOutlet weak var btn: UIButton!
    let TAX1 = "3.3%"
    let TAX2 = "7.8% (4대보험 가입시)"
    var btnClickCallback: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnClicked() {
        self.showListAlertView(title: "",
                               content: "해당되는 항목을 골라주세요",
                               items: [TAX1, TAX2]) { item in
            guard let selected = item else { return }
            self.btn.setTitle(selected, for: .normal)
            self.btnClickCallback?(selected)
        }
    }
}

class WorkSpaceAddScaleIVC: UIViewController {
    @IBOutlet weak var btn: UIButton!
    let OPTION1 = "5인 이상 사업장"
    let OPTION2 = "5인 미만 사업장"
    var btnClickCallback: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnClicked() {
        self.showListAlertView(title: "",
                               content: "해당되는 항목을 골라주세요",
                               items: [OPTION1, OPTION2]) { item in
            guard let selected = item else { return }
            self.btn.setTitle(selected, for: .normal)
            self.btnClickCallback?(selected)
        }
    }
}

class WorkSpaceAddWeekIVC: UIViewController {
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    
    
}
