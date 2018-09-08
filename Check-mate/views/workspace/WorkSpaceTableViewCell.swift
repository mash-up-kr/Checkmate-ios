//
//  WorkSpaceTableViewCell.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class WorkSpaceTableViewCell: UITableViewCell {

    @IBOutlet weak var workSpaceView: WorkSpaceView!
    @IBOutlet weak var workSpaceViewHeight: NSLayoutConstraint!

    var isLastCell: Bool {
        get {
            return workSpaceView.isLastCardView
        }
        set(isLast) {
            workSpaceViewHeight.constant = CGFloat(isLast ? WorkSpaceView.addBtnStatusHeight : WorkSpaceView.normalStatusHeight)
            workSpaceView.isLastCardView = isLast
        }
    }
}
