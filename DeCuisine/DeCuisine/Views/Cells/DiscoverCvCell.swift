//
//  DiscoverCvCell.swift
//  DeCuisine
//
//  Created by Erencan Evren on 3.09.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import UIKit

class DiscoverCvCell: UICollectionViewCell {
    @IBOutlet weak var imgReceipt: UIImageView!
    override func awakeFromNib() {
        self.layer.cornerRadius = 12
    }
}
