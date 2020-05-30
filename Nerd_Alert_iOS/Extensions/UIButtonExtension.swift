//
//  UIButtonExtension.swift
//  Nerd_Alert_iOS
//
//  Created by Ameer Bajwa on 5/29/20.
//  Copyright © 2020 Ameer Bajwa. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func xibViewDisplayButtonDesign(button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.textColor = UIColor.black
        button.backgroundColor = UIColor.opaqueSeparator
        button.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
    }
}
