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
    var weekIVC: WorkSpaceAddWeekIVC!
    var addressIVC: WorkSpaceAddLocationIVC!
    
    var totalIndex: Int = 0
    var nowIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subscribeToKeyboardNotifications()
        
        self.totalIndex = scrollView.subviews[0].subviews.count
        self.pageIndicator.initiate(totalPage: totalIndex)
        
        nameIVC.nextableCallback = { nextable in
            self.updateUI(nextable: nextable)
        }
        
        salaryIVC.nextableCallback = { nextable in
            self.updateUI(nextable: nextable)
        }
        
        paydayIVC.nextableCallback = { nextable in
            self.updateUI(nextable: nextable)
        }
        
        taxIVC.nextableCallback = { nextable in
            self.updateUI(nextable: nextable)
        }
        
        scaleIVC.nextableCallback = { nextable in
            self.updateUI(nextable: nextable)
        }
        
        addressIVC.nextableCallback = { nextable in
            self.updateUI(nextable: nextable)
        }
        
        updateUI(nowIndex: 0)
    }
    
    @IBAction func prevBtnClicked() {
        if nowIndex - 1 >= 0 {
            nowIndex -= 1
            pageIndicator.prev()
            updateUI(nowIndex: nowIndex)
        }
    }
    
    @IBAction func nextBtnClicked() {
        if nowIndex + 1 < totalIndex {
            nowIndex += 1
            pageIndicator.next()
            updateUI(nowIndex: nowIndex)
        } else if nowIndex + 1 == totalIndex {
            finish()
        }
    }
    
    private func updateUI(nowIndex: Int) {
        let tmp = CGPoint(x: CGFloat(nowIndex) * scrollView.frame.width, y: 0.0)
        scrollView.setContentOffset(tmp, animated: true)
        
        var nextable = false
        
        switch nowIndex {
        case 0:
            nameIVC.textField.becomeFirstResponder()
            nextable = nameIVC.nextable
        case 1:
            salaryIVC.textField.becomeFirstResponder()
            nextable = salaryIVC.nextable
        case 2:
            self.view.endEditing(true)
            nextable = probationIVC.nextable
        case 3:
            restIVC.textField.becomeFirstResponder()
            nextable = restIVC.nextable
        case 4:
            paydayIVC.textField.becomeFirstResponder()
            nextable = paydayIVC.nextable
        case 5:
            self.view.endEditing(true)
            nextable = taxIVC.nextable
        case 6:
            self.view.endEditing(true)
            nextable = scaleIVC.nextable
        case 7:
            self.view.endEditing(true)
            nextable = weekIVC.nextable
        case 8:
            self.view.endEditing(true)
            nextable = addressIVC.nextable
        default:
            return
        }
        
        bottomBtnBarLeading.constant = (nowIndex == 0) ? -self.view.frame.width : 0
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        })
        
        updateUI(nextable: nextable)
    }
    
    private func updateUI(nextable: Bool) {
        nextBtn.backgroundColor = nextable ? UIColor.blue1 : UIColor.grey204
        nextBtn.isEnabled = nextable
    }
    
    private func finish() {
        let name = nameIVC.name
        let address = addressIVC.address
        let latitude = addressIVC.lat
        let longitude = addressIVC.lng
        let hourlyWage = salaryIVC.salary
        let probation = probationIVC.probation
        let recess = restIVC.restTime
        let recessState = restIVC.isFreeRest ? 0 : 1
        let payDay = paydayIVC.payday
        let tax = taxIVC.tax
        let fiveState = scaleIVC.isBiggerThan5 ? 1 : 0
        let workingDay = weekIVC.workingDay
        
        ServerClient.addWorkSpace(name: name,
                                  address: address,
                                  latitude: latitude,
                                  longitude: longitude,
                                  hourlyWage: hourlyWage,
                                  probation: probation,
                                  recess: recess,
                                  recessState: recessState,
                                  payDay: payDay,
                                  tax: tax,
                                  fiveState: fiveState,
                                  workingDay: workingDay) { success in
            if (success) {
                self.dismiss(animated: true)
            }
        }
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
        case is WorkSpaceAddWeekIVC:
            weekIVC = vc as! WorkSpaceAddWeekIVC
        case is WorkSpaceAddLocationIVC:
            addressIVC = vc as! WorkSpaceAddLocationIVC
        default:
            return
        }
    }
}

class WorkSpaceAddNameIVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
    var nextable = false
    var nextableCallback: ((Bool) -> Void)?
    var name = ""
    
    @IBAction func textDidChange() {
        name = textField.text ?? ""
        nextable = name != ""
        nextableCallback?(nextable)
    }
}

class WorkSpaceAddSalaryIVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
    var nextable = false
    var nextableCallback: ((Bool) -> Void)?
    var salary = 0
    
    @IBAction func textDidChange() {
        salary = Int(textField.text ?? "0") ?? 0
        nextable = salary != 0
        nextableCallback?(nextable)
    }
}

class WorkSpaceAddProbationIVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var bar2: UIView!
    @IBOutlet weak var arrowDown: UIImageView!
    private let EXIST = "있습니다"
    private let NOTEXIST = "없습니다"
    var nextable = true
    var probationExist = false
    var probation = 0
    
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
    
    @IBAction func textDidChange() {
        probation = Int(textField.text ?? "0") ?? 0
    }
    
    private func updateUI() {
        self.button.setTitle(probationExist ? EXIST : NOTEXIST, for: .normal)
        
        bar2.backgroundColor = probationExist ? UIColor.white : UIColor.grey243
        button2.setTitleColor(probationExist ? UIColor.grey85 : UIColor.grey136, for: .normal)
        textField.isEnabled = probationExist
        textField.isHidden = !probationExist
        arrowDown.image = UIImage(named: probationExist ? "arrowDown2" : "arrowDown3")
        
        if probationExist {
            textField.becomeFirstResponder()
        }
    }
}

class WorkSpaceAddRestIVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var yuBtn: UIButton!
    @IBOutlet weak var muBtn: UIButton!
    var nextable = true
    var isFreeRest = false
    var restTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func textFieldDidChange() {
        restTime = Int(textField.text ?? "0") ?? 0
        updateUI()
    }
    
    @IBAction func btnClicked(_ btn: UIButton) {
        isFreeRest = btn == muBtn
        updateUI()
    }
    
    private func updateUI() {
        let selectedBackgroundColor = UIColor.blue1
        let deselectedBackgroundColor = UIColor.white
        let disabledBackgroundColor = UIColor.grey243
        
        if restTime == 0 {
            yuBtn.backgroundColor = disabledBackgroundColor
            muBtn.backgroundColor = disabledBackgroundColor
            yuBtn.isEnabled = false
            muBtn.isEnabled = false
        } else {
            yuBtn.backgroundColor = isFreeRest ? deselectedBackgroundColor : selectedBackgroundColor
            muBtn.backgroundColor = isFreeRest ? selectedBackgroundColor : deselectedBackgroundColor
            yuBtn.isSelected = !isFreeRest
            muBtn.isSelected = isFreeRest
            yuBtn.isEnabled = true
            muBtn.isEnabled = true
        }
    }
}

class WorkSpaceAddPaydayIVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
    var nextable = false
    var nextableCallback: ((Bool) -> Void)?
    var payday = 0
    
    @IBAction func textDidChange() {
        payday = Int(textField.text ?? "0") ?? 0
        nextable = payday != 0
        nextableCallback?(nextable)
    }
}

class WorkSpaceAddTAXIVC: UIViewController {
    @IBOutlet weak var btn: UIButton!
    private let TAX1 = "3.3%"
    private let TAX2 = "7.8% (4대보험 가입시)"
    var nextable = false
    var nextableCallback: ((Bool) -> Void)?
    var tax = 3.3
    
    @IBAction func btnClicked() {
        self.showListAlertView(title: "",
                               content: "해당되는 항목을 골라주세요",
                               items: [TAX1, TAX2]) { item in
            guard let selected = item else { return }
            self.btn.setTitle(selected, for: .normal)
            self.tax = (selected == self.TAX1) ? 3.3 : 7.8
            self.nextable = true
            self.nextableCallback?(self.nextable)
        }
    }
}

class WorkSpaceAddScaleIVC: UIViewController {
    @IBOutlet weak var btn: UIButton!
    private let OPTION1 = "5인 이상 사업장"
    private let OPTION2 = "5인 미만 사업장"
    var nextable = false
    var nextableCallback: ((Bool) -> Void)?
    var isBiggerThan5 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnClicked() {
        self.showListAlertView(title: "",
                               content: "해당되는 항목을 골라주세요",
                               items: [OPTION1, OPTION2]) { item in
            guard let selected = item else { return }
            self.btn.setTitle(selected, for: .normal)
            self.isBiggerThan5 = selected == self.OPTION1
            self.nextable = true
            self.nextableCallback?(self.nextable)
        }
    }
}

class WorkSpaceAddWeekIVC: UIViewController {
    @IBOutlet weak var btn1: OnOffButton!
    @IBOutlet weak var btn2: OnOffButton!
    @IBOutlet weak var btn3: OnOffButton!
    @IBOutlet weak var btn4: OnOffButton!
    @IBOutlet weak var btn5: OnOffButton!
    @IBOutlet weak var btn6: OnOffButton!
    @IBOutlet weak var btn7: OnOffButton!
    var nextable = true
    var workingDay: String {
        get {
            return [btn1, btn2, btn3, btn4, btn5, btn6, btn7]
                .map { $0!.isOn ? 1 : 0 }
                .reduce("") { $0 + "\($1)" }
        }
    }
}

class WorkSpaceAddLocationIVC: UIViewController {
    @IBOutlet weak var btn: UIButton!
    var nextable: Bool = false
    var nextableCallback: ((Bool) -> Void)? = nil
    var address: String = ""
    var lat: Double = 0.0
    var lng: Double = 0.0
    
    @IBAction func btnClicked() {
        let vc = UIStoryboard.instantiate(MapViewController.self, storyboardName: "MapViewController")
        vc.addressCallback = self.addressCallback
        self.present(vc, animated: true)
    }
    
    func addressCallback(address: String, lat: Double, lng: Double) {
        self.address = address
        self.lat = lat
        self.lng = lng
        
        btn.setTitle(address, for: .normal)
        
        nextable = address != ""
        nextableCallback?(nextable)
    }
}
