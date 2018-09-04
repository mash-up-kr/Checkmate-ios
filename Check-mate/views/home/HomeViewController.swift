//
//  HomeViewController.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    let circularGraph = CircularGraph()
    var workState: WorkState = .noWorking
    
    enum WorkState {
        case working
        case noWorking
    }
    @IBOutlet var shadowView: UIView!
    @IBOutlet weak var workStateButton: UIButton!
    @IBOutlet var payLabel: CountingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabShadowViewGesture = UITapGestureRecognizer.init(target: self, action: #selector(tabShadowView))
        shadowView.addGestureRecognizer(tabShadowViewGesture)
        shadowView.isHidden = true
        
        
        //setupCircularGraph(view: self.view, percentage: 0.1)
        workStateButton?.layer.cornerRadius = 25
        
        let graphCenterPos : CGPoint = CGPoint(x: view.center.x, y: view.center.y - 100)
        self.circularGraph.center = graphCenterPos
        self.circularGraph.trackLayer.fillColor = UIColor.clear.cgColor
        self.circularGraph.trackLayer.lineWidth = 3
        self.circularGraph.trackLayer.strokeColor = UIColor(displayP3Red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
        
        self.circularGraph.shapeLayer.lineWidth = 3
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
    
    @IBAction func touchUpSideMenuButton(_ sender: UIButton) {
        let parentController = self.parent as! SideMenuViewController
        parentController.modalSidebarMenu()
        shadowView.isHidden = false
    }
    
    @objc func tabShadowView(){
        let parentController = self.parent as! SideMenuViewController
        parentController.dismissSidebar()
        shadowView.isHidden = true
    }
}
