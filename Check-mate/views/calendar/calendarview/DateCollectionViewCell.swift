//
//  DateCollectionViewCell.swift
//  Check-mate
//
//  Created by 김선재 on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var CircleView: UIView!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var HighlightCircleView: UIView!
    @IBOutlet weak var BottomLineView: UIView!
    
    var isHighlight: Bool = true
    var isHistory: Bool = true
    var isBottomLine: Bool = true
    
    override func awakeFromNib() {
        DateLabel.isHidden = false
        DateLabel.text = ""
        
        PriceLabel.isHidden = false
        PriceLabel.text = ""
        
        if isHistory {
            ToggleHistory()
        }
        
        if isHighlight {
            ToggleHighlight()
        }
        
        if !isBottomLine {
            ToggleBottomLine()
        }
    }
    
    func cellHide() {
        cellClear()
        DateLabel.isHidden = true
        PriceLabel.isHidden = true
    }
    
    func cellClear() {
        self.awakeFromNib()
    }
    
    func ToggleHistory() {
        isHistory = !isHistory
        
        if isHistory {
            CircleView.isHidden = false
            CircleView.layer.cornerRadius = CircleView.bounds.size.height / 2
        }
        else {
            CircleView.isHidden = true
        }
    }
    
    func ToggleHighlight() {
        isHighlight = !isHighlight
        
        if isHighlight {
            HighlightCircleView.isHidden = false
            HighlightCircleView.layer.cornerRadius = HighlightCircleView.bounds.size.height / 2
            DateLabel.textColor = UIColor.white
        }
        else {
            HighlightCircleView.isHidden = true
            DateLabel.textColor = UIColor.init(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        }
    }
    
    func ToggleBottomLine() {
        isBottomLine = !isBottomLine
        
        if isBottomLine {
            BottomLineView.isHidden = false
        } else {
            BottomLineView.isHidden = true
        }
    }
    
}
