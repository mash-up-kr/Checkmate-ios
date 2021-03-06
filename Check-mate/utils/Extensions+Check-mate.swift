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

extension UIViewController {
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            view.frame.size.height = UIScreen.main.bounds.height - keyboardSize.height
            view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            view.frame.size.height = UIScreen.main.bounds.height
            view.layoutIfNeeded()
        }
    }
}

extension UIViewController {
    func showListAlertView(title: String = "",
                           content: String = "",
                           items: [String] = [],
                           callback: ((String?) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: content, preferredStyle: .actionSheet)
        
        for item in items {
            let action = UIAlertAction(title: item, style: .default) { action in
                callback?(action.title)
            }
            
            alert.addAction(action)
        }
        
        let action = UIAlertAction(title: "Cancel", style: .cancel) { action in
            callback?(nil)
        }
        alert.addAction(action)
        
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
        }
        
        self.present(alert, animated: true)
    }
}

// From https://stackoverflow.com/a/29999137
extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

// From https://stackoverflow.com/a/29999137
extension BinaryInteger {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
