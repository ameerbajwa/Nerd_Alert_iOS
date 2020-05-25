//
//  UITextViewExtension.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 5/24/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    func creatingPresentableTextFields(textView: UITextView) {
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 2.5
        textView.clipsToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
    }
}
