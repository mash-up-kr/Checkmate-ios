//
//  HomeViewController.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let circularGraph = CircularGraph()
    var workState: WorkState = .noWorking
    
    var today = 23.0
    var lastday = 31.0
    
    enum WorkState {
        case working
        case noWorking
    }
    
    
    @IBOutlet weak var workStateButton: UIButton!
    @IBOutlet var payLabel: CountingLabel!

    @IBOutlet weak var dDayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workStateButton?.layer.cornerRadius = 25
        
        let graphCenterPos : CGPoint = CGPoint(x: view.center.x, y: view.center.y - 100)
        self.circularGraph.center = graphCenterPos
        self.circularGraph.trackLayer.fillColor = UIColor.clear.cgColor
        self.circularGraph.trackLayer.lineWidth = 3
        self.circularGraph.trackLayer.strokeColor = UIColor(displayP3Red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
    
        self.circularGraph.shapeLayer.lineWidth = 3
        self.circularGraph.shapeLayer.strokeColor = UIColor(displayP3Red: 48/255, green: 79/255, blue: 254/255, alpha: 1.0).cgColor
        self.view.addSubview(circularGraph)
        
        self.circularGraph.percentage = CGFloat.init(today/lastday)
        let d_day = Int(lastday - today)
        self.dDayLabel.text = "\(d_day)일"
        
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
        self.payLabel.count(fromValue: 0, to: 691200, withDuration: 0.8, andAnimationType: .EaseOut, andCouterType: .Int)
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

}
