//
//  LoadingDialog.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 9. 7..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class LoadingDialog: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        let background = UIView(frame: self.bounds)
        background.backgroundColor = UIColor(white: 0, alpha: 0.3)
        self.addSubview(background)
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        indicator.center = self.center
        indicator.startAnimating()
        self.addSubview(indicator)
    }
}
