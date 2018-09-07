//
//  WorkSpaceCell.swift
//  Check-mate
//
//  Created by Changmin Kim on 2018. 9. 8..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class WorkSpaceCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let bgView : UIView = UIView()
        bgView.backgroundColor = UIColor.blue1
        self.selectedBackgroundView = bgView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        if self.isSelected{
            self.textLabel?.textColor = UIColor.white
        }else{
            self.textLabel?.textColor = UIColor.black
        }
    }

}
