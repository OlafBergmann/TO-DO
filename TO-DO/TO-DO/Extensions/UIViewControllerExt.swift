//
//  UIViewControllerExt.swift
//  TO-DO
//
//  Created by Olaf Bergmann on 18/08/2019.
//  Copyright © 2019 Olaf Bergmann. All rights reserved.
//

import UIKit


extension UIViewController {
    func hideKeyboardOnTap(_ selector: Selector) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
