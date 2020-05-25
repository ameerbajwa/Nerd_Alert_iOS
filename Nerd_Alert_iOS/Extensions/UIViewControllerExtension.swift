//
//  UIViewControllerExtension.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 5/25/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func setupToHideKeyboardOnTapOnView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
