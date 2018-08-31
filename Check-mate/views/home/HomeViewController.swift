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
    
    enum WorkState {
        case working
        case noWorking
    }
    @IBOutlet weak var workStateButton: UIButton!
    @IBOutlet var payLabel: CountingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupCircularGraph(view: self.view, percentage: 0.1)
        workStateButton?.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
        
        self.circularGraph.center = view.center
        self.circularGraph.trackLayer.fillColor = UIColor.clear.cgColor
        self.circularGraph.trackLayer.lineWidth = 7
        self.circularGraph.trackLayer.strokeColor = UIColor(displayP3Red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
        
        self.circularGraph.shapeLayer.lineWidth = 12
        self.circularGraph.shapeLayer.strokeColor = UIColor(displayP3Red: 48/255, green: 79/255, blue: 254/255, alpha: 1.0).cgColor
        self.view.addSubview(circularGraph)
        self.circularGraph.percentage = 3/4
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.payLabel.count(fromValue: 60000, to: 691200, withDuration: 2, andAnimationType: .EaseOut, andCouterType: .Int)
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
    
    
    @IBAction func monthClicked() {
//        let vc = UIStoryboard.instantiate(MonthViewController.self, storyboardName: "MonthViewController")
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
