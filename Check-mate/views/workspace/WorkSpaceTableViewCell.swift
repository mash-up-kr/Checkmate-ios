//
//  WorkSpaceTableViewCell.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class WorkSpaceTableViewCell: UITableViewCell {

    static var workSpaceViewBottomOrigin: CGFloat = 0.0

    @IBOutlet weak var workSpaceView: WorkSpaceView!
    @IBOutlet weak var workSpaceViewBottom: NSLayoutConstraint!

    var isLastCell: Bool {
        get {
            return workSpaceView.isLastCardView
        }
        set(b) {
            workSpaceViewBottom.constant = b ? WorkSpaceTableViewCell.workSpaceViewBottomOrigin : 0.0
            workSpaceView.isLastCardView = b
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        WorkSpaceTableViewCell.workSpaceViewBottomOrigin = workSpaceViewBottom.constant
    }
}
