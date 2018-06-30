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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupCircularGraph(view: self.view, percentage: 0.1)
        
        // Do any additional setup after loading the view.
        let circularGraph = CircularGraph()
        circularGraph.center = self.view.center
        self.view.addSubview(circularGraph)
        
        circularGraph.percentage = 0.5
        circularGraph.trackLayer.fillColor = UIColor.clear.cgColor
        circularGraph.shapeLayer.strokeColor = UIColor.blue.cgColor
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
    
    @IBAction func touchUpWorkingButton(){
        //off로 가면 post요청
    }
    
    @IBAction func touchUpBreakTimeButton(){
        //사용하면 post요청
    }
    
    @IBAction func monthClicked() {
        let vc = UIStoryboard.instantiate(MonthViewController.self, storyboardName: "MonthViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
