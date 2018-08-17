//
//  UIImageViewDesignable.swift
//  DeCuisine
//
//  Created by Erencan Evren on 16.08.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import UIKit

@IBDesignable
class UIImageViewDesignable: UIImageView {
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
    
}
