//
//  WorkSpaceView.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class WorkSpaceView: UIView {

    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var addBtn: UIButton!

    var addBtnCallback: (() -> Void)?

    private var mIsLastCardView = false
    var isLastCardView: Bool {
        get {
            return mIsLastCardView
        }
        set(b) {
            mIsLastCardView = b
            addBtn.isHidden = !mIsLastCardView
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        self.loadNib(String(describing: WorkSpaceView.self))

        rootView.layer.cornerRadius = 10
    }

    @IBAction func addBtnClicked(_ sender: Any) {
        addBtnCallback?()
    }
}
