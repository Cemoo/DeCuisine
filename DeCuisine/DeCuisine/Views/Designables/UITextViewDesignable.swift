//
//  UITextViewDesignable.swift
//  DuupleV1
//
//  Created by Gökhan Mandacı on 25/08/2017.
//  Copyright © 2017 Face It For Me, Llc. All rights reserved.
//

import UIKit

@IBDesignable
class UITextViewDesignable: UITextView {

    // MARK: - Border
    
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

}
