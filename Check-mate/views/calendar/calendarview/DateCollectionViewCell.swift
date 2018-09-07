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
    
    var isHighlight: Bool = true
    var isHistory: Bool = true
    var isPayDay: Bool = true
    
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
        
        if isPayDay {
            TogglePayDay()
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
            CircleView.layer.borderWidth = 1
            CircleView.layer.borderColor = UIColor.init(red: 155 / 255, green: 155 / 255, blue: 155 / 255, alpha: 1.0).cgColor
            CircleView.layer.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0).cgColor
            DateLabel.textColor = UIColor.init(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        }
        else {
            CircleView.isHidden = true
        }
    }
    
    func TogglePayDay() {
        isPayDay = !isPayDay
        
        if isPayDay {
            CircleView.isHidden = false
            CircleView.layer.cornerRadius = CircleView.bounds.size.height / 2
            CircleView.layer.borderWidth = 0
            CircleView.layer.backgroundColor = UIColor.init(red: 48 / 255, green: 79 / 255, blue: 254 / 255, alpha: 1.0).cgColor
            DateLabel.textColor = UIColor.white
        }
        else {
            isHistory = !isHistory
            ToggleHistory()
        }
    }
    
    func ToggleHighlight() {
        isHighlight = !isHighlight
        
        if isHighlight {
            HighlightCircleView.isHidden = false
            HighlightCircleView.layer.cornerRadius = HighlightCircleView.bounds.size.height / 2
            HighlightCircleView.backgroundColor = UIColor.init(red: 247 / 255, green: 114 / 255, blue: 132 / 255, alpha: 1)
        }
        else {
            HighlightCircleView.isHidden = true
        }
    }
    
}
