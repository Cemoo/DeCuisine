//
//  SelectedReceiptVC.swift
//  DeCuisine
//
//  Created by Erencan Evren on 10.08.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import UIKit

class SelectedReceiptVC: UIViewController {

    @IBOutlet weak var imgSelectedReceipt: UIImageView!
    @IBOutlet weak var tbReceipt: UITableView!
    
    var backImage: UIImage?
    
    override func viewDidAppear(_ animated: Bool) {
        imgSelectedReceipt.image = backImage
        setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupTableView() {
        tbReceipt.delegate = self
        tbReceipt.dataSource = self
        tbReceipt.contentInset = UIEdgeInsets(top: self.view.frame.size.height * 0.4, left: 0, bottom: 0, right: 0)
    }

}

extension SelectedReceiptVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension SelectedReceiptVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 270 - (scrollView.contentOffset.y + 270)
        print(y)
        
        let height = min(max(y, 200), 600)
        self.imgSelectedReceipt.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.size.width), height: Int(height))
        self.imgSelectedReceipt.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        self.imgSelectedReceipt.layoutIfNeeded()
        
    }
}


