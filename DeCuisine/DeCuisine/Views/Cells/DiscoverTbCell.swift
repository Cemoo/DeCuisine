//
//  DiscoverTbCell.swift
//  DeCuisine
//
//  Created by Erencan Evren on 3.09.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import UIKit

class DiscoverTbCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var colRecipes: UICollectionView!
    
    var receiptImages: [UIImage] = [] {
        didSet {
            colRecipes.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        self.selectionStyle = .none
    }
    
    func setupCollectionView() {
        colRecipes.delegate = self
        colRecipes.dataSource = self
        colRecipes.register(UINib(nibName: "DiscoverCvCell", bundle: nil), forCellWithReuseIdentifier: "DiscoverCvCell")
    }
    
    fileprivate func setShadowFor(cell: DiscoverCvCell) {
        cell.contentView.layer.cornerRadius = 12
        //cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0,height: 2.0)
        cell.layer.shadowRadius = 10
        cell.layer.shadowOpacity = 0.7
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
    }

    
}

extension DiscoverTbCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return receiptImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colRecipes.dequeueReusableCell(withReuseIdentifier: "DiscoverCvCell", for: indexPath) as! DiscoverCvCell
        cell.imgReceipt.image = self.receiptImages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: self.colRecipes.frame.height)
    }
    
}
