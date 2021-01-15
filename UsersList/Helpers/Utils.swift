//
//  Utils.swift
//  UsersListTask
//
//  Created by Yerem Sargsyan on 29.12.20.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    func showImage(url : String) {
        self.sd_setImage(with: URL(string: url), completed: nil)
    }
}

extension UIColor {
    
    open class func saveButton() -> UIColor {
        return UIColor(red: 99.0/255.0, green: 211.0/255.0, blue: 127.0/255.0, alpha: 1.0)
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
