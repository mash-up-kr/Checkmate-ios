//
//  WorkSpaceView.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class WorkSpaceView: UIView {

    static var ORIGIN_BACKGROUND: UIColor = UIColor.black

    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var addBtn: UIView!

    var addBtnCallback: (() -> Void)?
    var detailCallback: (() -> Void)?

    private var mIsLastCardView = false
    var isLastCardView: Bool {
        get {
            return mIsLastCardView
        }
        set(b) {
            mIsLastCardView = b
            addBtn.isHidden = !mIsLastCardView
            rootView.backgroundColor = b ? UIColor.white : WorkSpaceView.ORIGIN_BACKGROUND
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

        WorkSpaceView.ORIGIN_BACKGROUND = rootView.backgroundColor!

        rootView.layer.cornerRadius = 5.0
        rootView.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1).cgColor
        rootView.layer.shadowRadius = 4
        rootView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        rootView.layer.shadowOpacity = 1.0
        rootView.layer.masksToBounds = false

        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(detailClicked)))
        self.addBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addBtnClicked)))
    }

    @IBAction func addBtnClicked() {
        addBtnCallback?()
    }

    @IBAction func detailClicked() {
        if !isLastCardView {
            detailCallback?()
        }
    }
}
