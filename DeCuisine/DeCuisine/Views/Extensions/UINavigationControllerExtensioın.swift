//
//  UINavigationControllerExt.swift
//  DeCuisine
//
//  Created by Erencan Evren on 7.08.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override func awakeFromNib() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }
}
