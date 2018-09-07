//
//  PageIndicator.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 8. 29..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class PageIndicator: UIView {
    
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    var totalPage: Int = 0
    var nowPage: Int = 0
    
    func initiate(totalPage: Int) {
        self.totalPage = totalPage
        
        backgroundColor = UIColor.grey238
        
        view1 = UIView(frame: self.bounds)
        view1.frame.size.width = self.frame.width / CGFloat(totalPage)
        view1.backgroundColor = UIColor.blue1
        
        view2 = UIView(frame: self.bounds)
        view2.frame.size.width = 0
        view2.backgroundColor = UIColor.blue2
        
        addSubview(view2)
        addSubview(view1)
    }
    
    func next() {
        if (nowPage + 1 < totalPage) {
            nowPage += 1
            updateUI()
        }
    }
    
    func prev() {
        if (nowPage - 1 >= 0) {
            nowPage -= 1
            updateUI()
        }
    }
    
    private func updateUI() {
        UIView.animate(withDuration: 0.4, animations: {
            self.view1.frame.origin.x = self.view1.frame.width * CGFloat(self.nowPage)
            self.view2.frame.size.width = self.view1.frame.width * CGFloat(self.nowPage)
        })
    }
}
