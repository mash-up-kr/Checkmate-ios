//
//  SideViewNavigationController.swift
//  Check-mate
//
//  Created by Changmin Kim on 2018. 8. 5..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit
import SideMenu
class SideMenuViewNavigationController: UISideMenuNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var testButton = UIButton(frame: CGRect(x: 250, y: 50, width: 50, height: 50))
        testButton.setTitle("hi", for: .normal)
        testButton.setTitleColor(UIColor.red, for: .normal)
        testButton.addTarget(self, action: #selector(testAction), for: .touchUpInside)
        testButton.backgroundColor = UIColor.black
        self.view.addSubview(testButton)
        
        // Do any additional setup after loading the view.
        self.sideMenuManager.menuPresentMode = .menuSlideIn
        self.sideMenuManager.menuAnimationFadeStrength = 0.5
        
        self.sideMenuManager.menuLeftNavigationController = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testAction(sender: UIButton){
        print("hi")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
