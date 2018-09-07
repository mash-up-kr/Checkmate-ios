//
//  WorkSpaceView.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class WorkSpaceView: UIView {
    static var normalStatusHeight = 200.0
    static var addBtnStatusHeight = 60.0

    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var addBtn: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var payLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var probationLabel: UILabel!
    var workSpace: WorkSpace?

    var addBtnCallback: (() -> Void)?
    var detailCallback: (() -> Void)?

    private var mIsLastCardView = false
    var isLastCardView: Bool {
        get {
            return mIsLastCardView
        }
        set(b) {
            mIsLastCardView = b
            view1.isHidden = mIsLastCardView
            view2.isHidden = mIsLastCardView
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

        rootView.layer.cornerRadius = 2.0
        rootView.layer.shadowColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 0.5).cgColor
        rootView.layer.shadowRadius = 3
        rootView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        rootView.layer.shadowOpacity = 1.0
        rootView.layer.masksToBounds = false

        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(detailClicked)))
        self.addBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addBtnClicked)))
    }
    
    func setWorkSpace(workSpace: WorkSpace) {
        self.workSpace = workSpace
        nameLabel.text = workSpace.name
        payLabel.text = String(workSpace.wage)
        locationLabel.text = workSpace.address
        probationLabel.text = "\(workSpace.probation) 개월"
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
