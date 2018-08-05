//
//  CalendarBenefitCell.swift
//  Check-mate
//
//  Created by 김선재 on 2018. 8. 3..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class CalendarBenefitCell: UICollectionViewCell {
    
    
    @IBOutlet weak var extraImage: UIImageView!
    @IBOutlet weak var extraTitleLabel: UILabel!
    @IBOutlet weak var extraPayLabel: UILabel!
    @IBOutlet weak var sepView: UIView!
    
    override func awakeFromNib() {
        
    }
    
    func hideSeparateView() {
        sepView.isHidden = true
    }
}
