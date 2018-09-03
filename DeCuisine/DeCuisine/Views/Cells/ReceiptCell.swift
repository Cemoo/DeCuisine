//
//  ReceiptCell.swift
//  DeCuisine
//
//  Created by Erencan Evren on 7.08.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import UIKit

class ReceiptCell: UICollectionViewCell {
    
    @IBOutlet weak var imgReceipt: UIImageView!
    @IBOutlet weak var lblMealNAme: UILabel!
    @IBOutlet weak var imgCenterYAlignmentConst: NSLayoutConstraint!
    
    var receiptsController: RecipesVC?
    
    var paralaxOffset: CGFloat = 0 {
        didSet {
            imgCenterYAlignmentConst.constant = paralaxOffset
        }
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 20
        self.imgReceipt.layer.cornerRadius = 20
        self.imgReceipt.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.animate))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func animate() {
        receiptsController?.addImageView(image: self.imgReceipt)
    }
    
    func updateParalaxOffset(collectionviewbounds bounds: CGRect) {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let offsetFromCenter = CGPoint(x: center.x - self.center.x, y: center.y - self.center.y)
        let maxVerticalOffset = (bounds.width / 2) + (self.bounds.width / 2)
        let scaleFactor = 80 / maxVerticalOffset
        paralaxOffset = offsetFromCenter.x * scaleFactor
    }
    
}
