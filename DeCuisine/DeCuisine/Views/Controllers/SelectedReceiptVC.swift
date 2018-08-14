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
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblIUsername: UILabel!
    
    
    var backImage: UIImage?
    
    override func viewDidAppear(_ animated: Bool) {
        imgSelectedReceipt.image = backImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        updateUI()
    }
    
    private func setupTableView() {
        tbReceipt.delegate = self
        tbReceipt.dataSource = self
        tbReceipt.register(UINib(nibName: "MaterialCell", bundle: nil), forCellReuseIdentifier: "material")
        tbReceipt.tableFooterView = UIView()
        tbReceipt.separatorStyle = .none
    }
    
    fileprivate func updateUI() {
        imgUser.layer.cornerRadius = self.imgUser.frame.height / 2
        imgUser.clipsToBounds = true
    }

}

extension SelectedReceiptVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbReceipt.dequeueReusableCell(withIdentifier: "material", for: indexPath) as! MaterialCell
        cell.lblName.text = "test"
        cell.lblAmount.text = "2 kg"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}



