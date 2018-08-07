//
//  RecipesVC.swift
//  DeCuisine
//
//  Created by Erencan Evren on 7.08.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import UIKit

class RecipesVC: UIViewController {

    @IBOutlet weak var colRecipes: UICollectionView!
    @IBOutlet weak var imgBack: UIImageView!
    
    let images = [#imageLiteral(resourceName: "IMG_0532"),#imageLiteral(resourceName: "IMG_0518"),#imageLiteral(resourceName: "img1")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        colRecipes.delegate = self
        colRecipes.dataSource = self
        
        colRecipes.register(UINib(nibName: "ReceiptCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}

extension RecipesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colRecipes.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ReceiptCell
        cell.imgReceipt.image = images[indexPath.row]
        cell.updateParalaxOffset(collectionviewbounds: colRecipes.bounds)
        changeBackImage(for: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: colRecipes.frame.size.width - 40, height: colRecipes.frame.size.height - 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellWidth: CGFloat = colRecipes.frame.width - 40 // Your cell width
        
        let numberOfCells = floor(view.frame.size.width / cellWidth)
        let edgeInsets = (view.frame.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
        
        return UIEdgeInsetsMake(0, edgeInsets, 0, edgeInsets)
    }
    
    func changeBackImage(for cell: ReceiptCell) {
        UIView.animate(withDuration: 0.2) {
             self.imgBack.image = cell.imgReceipt.image
        }
       
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        DispatchQueue.main.async {
            let cells = self.colRecipes.visibleCells as! [ReceiptCell]
            let bounds = self.colRecipes!.bounds
            for cell in cells {
                cell.updateParalaxOffset(collectionviewbounds: bounds)
            }
        }
       
        
    }
    
     
    
}

