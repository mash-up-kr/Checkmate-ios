//
//  HomeViewController.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

enum WorkState : Int{
    case working = 1
    case noWorking = 0
}

class HomeViewController: UIViewController {
    let circularGraph = CircularGraph()
    var circleNumber: UILabel!
    var workState: WorkState = .noWorking
    var workSpace: WorkSpace!
    var workRecord: WorkRecord!
    
    @IBOutlet weak var jobLabel: UILabel!
    var today = 23
    var lastday = 31
    var pay: Int = 691200
    var job: String = "Mash up"
    var totalworkTime: Int = 72
    var payPerTime: Int = 8000
    
    
    func updateHomeView(workSpace: WorkSpace){
        setWorkRecordFromServer(workSpace)
        jobLabel.text = workSpace.name
        payPerTimeLabel.text = "\(workSpace.wage)"
        self.workSpace = workSpace
    }
    
    func setWorkRecordFromServer(_ workSpace: WorkSpace){
        ServerClient.getWorkRecord(workSpace: workSpace){ workRecord in
            //DispatchQueue.main.async {
                self.workRecord = workRecord
                self.totalworkTime = workRecord.totalHour
                self.payPerTime = workRecord.hourlyWage
                self.pay = workRecord.totalMoney
                self.payLabel.text = "\(workRecord.totalMoney)"
                self.dDayLabel.text = "\(workRecord.totalDay)일"
                self.payLabel.count(fromValue: 0, to: Float(self.pay), withDuration: 0.8, andAnimationType: .EaseOut, andCouterType: .Int)
                self.circularGraph.percentage = CGFloat(workRecord.baseDay - workRecord.totalDay)/CGFloat(workRecord.baseDay)
                self.drawGraphPoint(day: workRecord.baseDay - workRecord.totalDay, center: CGPoint(x: self.view.center.x, y: self.payLabel.superview!.center.y))
            //}
        }
    }
    
    func getGraphPercentage() -> CGFloat{
        return CGFloat.init(Double(workRecord.totalDay - workRecord.baseDay)/Double(workRecord.baseDay))
    }
    
    @IBOutlet weak var todayLabel: UILabel!
    
    @IBOutlet weak var workStateButton: UIButton!
    @IBOutlet var payLabel: CountingLabel!
    
    @IBOutlet weak var payPerTimeLabel: UILabel!
    @IBOutlet weak var dDayLabel: UILabel!
    
    @IBOutlet weak var workTimeLabel: UILabel!
    
    func getTodayInfo(){
        //오늘 날짜 구하기
        let datefomatter: DateFormatter = DateFormatter()
        datefomatter.dateFormat = "yyyy년 MM월 dd일"
        let now = Date()
        let last = now.endOfMonth()
        today = now.day
        lastday = last.day
        
        todayLabel.text = datefomatter.string(for: now)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        payLabel.text = "\(pay)"
        jobLabel.text = job
        payPerTimeLabel.text = "\(payPerTime)"
        workTimeLabel.text = "\(totalworkTime)"
        
        workStateButton?.layer.cornerRadius = 25
        
        let graphCenterPos : CGPoint = CGPoint(x: view.center.x, y: payLabel.superview!.center.y)
        self.circularGraph.center = graphCenterPos
        self.circularGraph.trackLayer.fillColor = UIColor.clear.cgColor
        self.circularGraph.trackLayer.lineWidth = 3
        self.circularGraph.trackLayer.strokeColor = UIColor(displayP3Red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
    
        self.circularGraph.shapeLayer.lineWidth = 3
        self.circularGraph.shapeLayer.strokeColor = UIColor(displayP3Red: 48/255, green: 79/255, blue: 254/255, alpha: 1.0).cgColor
        self.view.addSubview(circularGraph)
        
        getTodayInfo()
        
        self.circularGraph.percentage = CGFloat.init(Double(today)/Double(lastday))
        let d_day = lastday - today
        print(d_day)
        self.dDayLabel.text = "\(d_day)일"
        
        //그래프 끝에 동그라미 그리기 - 개어렵다.
        let degree = CGFloat(Double.pi * 2) *  self.circularGraph.percentage - CGFloat(Double.pi/2)
        let x = graphCenterPos.x + cos(degree) * self.circularGraph.radius
        let y = graphCenterPos.y + sin(degree) * self.circularGraph.radius
        let rect: CGRect = CGRect.init(x: x-20, y: y-20, width: 40, height: 40)
        self.circleNumber = UILabel.init(frame: rect)
        self.circleNumber.layer.masksToBounds = true
        self.circleNumber.layer.cornerRadius = 20
        self.circleNumber.text = "\(today)일"
        self.circleNumber.font = UIFont.systemFont(ofSize: 14)
        self.circleNumber.textAlignment = .center
        self.circleNumber.textColor = UIColor.white
        self.circleNumber.backgroundColor = UIColor.init(red: 48/255, green: 79/255, blue: 254/255, alpha: 1.0)
        view.addSubview(circleNumber)

        self.payLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(payLabelClicked)))
    }

    func drawGraphPoint(day: Int, center: CGPoint){
        let degree = CGFloat(Double.pi * 2) *  self.circularGraph.percentage - CGFloat(Double.pi/2)
        let x = center.x + cos(degree) * self.circularGraph.radius
        let y = center.y + sin(degree) * self.circularGraph.radius
        let rect: CGRect = CGRect.init(x: x-20, y: y-20, width: 40, height: 40)
        self.circleNumber.frame = rect
        circleNumber.layer.masksToBounds = true
        circleNumber.layer.cornerRadius = 20
        circleNumber.text = "\(day)일"
        circleNumber.font = UIFont.systemFont(ofSize: 14)
        circleNumber.textAlignment = .center
        circleNumber.textColor = UIColor.white
        circleNumber.backgroundColor = UIColor.init(red: 48/255, green: 79/255, blue: 254/255, alpha: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func touchUpWorkStateButton(){
        //off로 가면 post요청
        ServerClient.setWorkState(workSpace: self.workSpace, workState: self.workState)
        if workState == .noWorking{
            workState = .working
            self.workStateButton.setTitle("Stop Work", for: .normal)
            self.workStateButton.backgroundColor = UIColor(displayP3Red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
            self.workStateButton.setTitleColor(UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1.0), for: .normal)
            
        }else{
            workState = .noWorking
            self.workStateButton.setTitle("Start Work", for: .normal)
            self.workStateButton.backgroundColor = UIColor(displayP3Red: 48/255, green: 79/255, blue: 254/255, alpha: 1.0)
            self.workStateButton.setTitleColor(UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        }
    }
    
    @IBAction func touchUpSideMenuButton(_ sender: UIButton) {
        let parentController = self.parent as! SideMenuViewController
        parentController.modalSidebarMenu()
    }

    @IBAction func payLabelClicked() {
        let vc = UIStoryboard.instantiate(MonthViewController.self, storyboardName: "MonthViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}
