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
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnClap: ClapButton!
    
    // MARK: DUMMY DATAS
    let images = [#imageLiteral(resourceName: "IMG_0532"),#imageLiteral(resourceName: "IMG_0518"),#imageLiteral(resourceName: "img1")]
    let names = ["Cemal BAYRI", "Mete SOYDAŞ", "Erkan SİVAS"]
    let mealNames = ["Ev yapımı pizza", "Ev yapımı bira tabağı", "Havuçlu cevizli kek"]
    let usernames = [#imageLiteral(resourceName: "cemo"),#imageLiteral(resourceName: "mete"),#imageLiteral(resourceName: "erkan")]
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupBottomView()
    }
    
    private func setupCollectionView() {
        colRecipes.delegate = self
        colRecipes.dataSource = self
        colRecipes.register(UINib(nibName: "ReceiptCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        changeUserNameInBottomView(with: 0)
        changeBackImage(index: 0)
    }
    
    
    private func setupBottomView() {
        btnClap.tintColor = UIColor.white
        imgUser.layer.cornerRadius = 32
        imgUser.layer.borderWidth = 2
        imgUser.layer.borderColor = UIColor.white.cgColor
        imgUser.clipsToBounds = true
    }
    
    
    @IBAction func btnClapAction(_ sender: ClapButton) {
        sender.clap()
    }
    
    
}

extension RecipesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colRecipes.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ReceiptCell
        cell.imgReceipt.image = images[indexPath.row]
        cell.lblMealNAme.text = mealNames[indexPath.row]
        cell.updateParalaxOffset(collectionviewbounds: colRecipes.bounds)
        setShadowFor(cell: cell)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    
    fileprivate func changeBackImage(index: Int) {
        UIView.animate(withDuration: 0.2) {
             self.imgBack.image = self.images[index]
        }
    }
    
    fileprivate func setShadowFor(cell: ReceiptCell) {
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0,height: 2.0)
        cell.layer.shadowRadius = 10
        cell.layer.shadowOpacity = 0.7
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
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
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = colRecipes.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        pageControl?.currentPage = Int(roundedIndex)
        changeUserNameInBottomView(with: Int(roundedIndex))
        changeBackImage(index: Int(roundedIndex))
    }

    
    func changeUserNameInBottomView(with index: Int) {
        DispatchQueue.main.async {
            self.lblUsername.text = self.names[index]
            self.imgUser.image = self.usernames[index]
        }
        
    }
}

