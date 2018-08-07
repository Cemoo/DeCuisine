//
//  UITextFieldDesignable.swift
//  DuupleV1
//
//  Created by Cemal Bayrı on 28.11.2017.
//  Copyright © 2017 Face It For Me, Llc. All rights reserved.
//

import UIKit
@IBDesignable

class UITextFieldDesignable: UITextField {
    @IBInspectable var insetX: CGFloat = 6 {
        didSet {
            layoutIfNeeded()
        }
    }
    @IBInspectable var insetY: CGFloat = 0 {
        didSet {
            layoutIfNeeded()
        }
    }
    
    @IBInspectable var borderWidth: Float = 0.5 {
        didSet {
            layoutIfNeeded()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            layoutIfNeeded()
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
    
}
