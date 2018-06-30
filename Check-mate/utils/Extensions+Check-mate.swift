//
//  Extensions+Check-mate.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static func instantiate<T: UIViewController>(_ type: T.Type, storyboardName: String? = nil) -> T {
        let name = String(describing: type)
        let storyboardName = storyboardName ?? name
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name)
        
        guard let vc2 = vc as? T else {
            fatalError("Cannot cast '\(vc)' to '\(name)'")
        }
        
        return vc2
    }
}

extension UIView {
    func loadNib(_ nibName: String) {
        guard let view = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView else {
            fatalError("There is no nib whose name is '\(nibName)'")
        }
        
        view.frame = bounds
        addSubview(view)
    }
}
