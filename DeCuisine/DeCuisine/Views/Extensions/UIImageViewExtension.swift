//
//  UIImageViewExtension.swift
//  DeCuisine
//
//  Created by Erencan Evren on 31.08.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView {
    func download(with url: URL) {
        self.sd_setImage(with: url) { (image, error, cache, nil) in
            self.image = image
        }
    }
}
