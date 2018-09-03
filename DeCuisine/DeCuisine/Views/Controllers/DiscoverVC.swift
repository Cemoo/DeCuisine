//
//  DiscoverVC.swift
//  DeCuisine
//
//  Created by Erencan Evren on 3.09.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import UIKit

class DiscoverVC: UIViewController {
    
    @IBOutlet weak var tbSections: UITableView!
    var images = [#imageLiteral(resourceName: "IMG_0532"),#imageLiteral(resourceName: "IMG_0518")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    func setupTableView() {
        tbSections.delegate = self
        tbSections.dataSource = self
        tbSections.register(UINib(nibName: "DiscoverTbCell", bundle: nil), forCellReuseIdentifier: "DiscoverTbCell")
        tbSections.tableFooterView = UIView()
    }
    
    fileprivate func setShadowFor(cell: UITableViewCell) {
        cell.contentView.layer.cornerRadius = 12
        //cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0,height: 1.0)
        cell.layer.shadowRadius = 8
        cell.layer.shadowOpacity = 0.3
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
    }

}

extension DiscoverVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tbSections.dequeueReusableCell(withIdentifier: "HeaderTbCell", for: indexPath) as! HeaderTbCell
            setShadowFor(cell: cell)
            return cell
        } else {
            let cell = tbSections.dequeueReusableCell(withIdentifier: "DiscoverTbCell", for: indexPath) as! DiscoverTbCell
            setShadowFor(cell: cell)
            cell.receiptImages = self.images
            if indexPath.row == 1 {
                cell.lblTitle.text = "TRENDLER"
            } else {
                cell.lblTitle.text = "SON EKLENENLER"
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return self.tbSections.frame.height / 3
        } else {
            return 200
        }
    }
}
