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
    func simpleButtonDesign(button: UIButton) {
//        301,303,83, 31
//
//        let lightBlueImage = UIImage(named: "buttonColor")
//        lightBlueImage?.size = CGSize(width: 83, height: 31)
        
//        button.setBackgroundImage(UIImage(named: "buttonColor"), for: .normal)

        button.layer.borderWidth = 0
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
//        button.showsTouchWhenHighlighted = true
        
    }
    
//    class HighlightedButton: UIButton {
//        override var isHighlighted: Bool {
//            didSet {
//                backgroundColor = isHighlighted ? .red : .green
//            }
//        }
//    }
}
