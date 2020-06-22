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
    func simpleButtonDesign(button: UIButton, borderWidth: CGFloat) {

        button.layer.borderWidth = borderWidth
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        
    }
}
