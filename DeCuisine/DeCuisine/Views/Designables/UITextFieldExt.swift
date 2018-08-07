//
//  UITextFieldExt.swift
//  faceitforme
//
//  Created by gokhanmandaci on 27/02/2017.
//  Copyright © 2017 Face It For Me, Llc. All rights reserved.
//

import Foundation
import UIKit

/// UITextField extension
extension UITextField {
    
    /**
     Sets textfield font size to appropriate size according to design.
     
     ### Usage Example: ###
     ````
     textField.setTextSizeForDevice()
     ````
     
     - Returns: None.
     */
    func setTextSizeForDevice() {
        if UIDevice.current.model == "iPhone 7 Plus" || UIDevice.current.model == "iPhone 6 Plus" || UIDevice.current.model == "Simulator" {
            self.font = UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)! * 1.1)!
        } else if UIDevice.current.model == "iPhone 7" || UIDevice.current.model == "iPhone 6" || UIDevice.current.model == "iPhone 6s" {
            self.font = UIFont(name: (self.font?.fontName)!, size: (self.font?.pointSize)!)!
        } else if UIDevice.current.model == "iPhone 5" || UIDevice.current.model == "iPhone 5s" || UIDevice.current.model == "iPhone 5c" || UIDevice.current.model == "iPhone SE" {
            self.font = UIFont(name: (self.font?.fontName)!, size: ((self.font?.pointSize)! * 0.85))!
        }
    }
    
    /**
     Edits letter spacing.
     
     - Parameter spaceValue: Takes CGFloat value for the gaps between characters.
     
     ### Usage Example: ###
     ````
     setLetterSpacing(0.5)
     ````
     
     - Returns: None.
     */
    func setLetterSpacing(_ spaceValue: CGFloat){
        let attributedString = NSMutableAttributedString(string: self.text!)
        attributedString.addAttribute(NSAttributedStringKey.kern, value: spaceValue, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: self.textColor!, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
 
}
