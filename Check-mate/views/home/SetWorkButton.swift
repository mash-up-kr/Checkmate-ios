//
//  RoundFloatingButton.swift
//  Check-mate
//
//  Created by Changmin Kim on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class SetWorkButton: UIButton {
    func setupUI(){
        layer.cornerRadius = frame.width/2;
        layer.masksToBounds = true
    }
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
}
