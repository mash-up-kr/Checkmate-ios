//
//  WorkSpaceTableViewCell.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class WorkSpaceTableViewCell: UITableViewCell {
    static let CELL_INSET = CGFloat(12)

    @IBOutlet var workSpaceView: WorkSpaceView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if workSpaceView != nil {
            let isLastCell = workSpaceView.isLastCardView
            var f = self.bounds
            f.size.height -= isLastCell ? 0 : WorkSpaceTableViewCell.CELL_INSET
            workSpaceView.frame = f
        }
    }
}
