//
//  ProfileVC.swift
//  DeCuisine
//
//  Created by Erencan Evren on 3.09.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var tbProfile: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarUI()
        setupTableView()
    }
    
    private func setNavigationBarUI() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    fileprivate func setupTableView() {
        tbProfile.delegate = self
        tbProfile.dataSource = self
        tbProfile.tableFooterView = UIView()
        tbProfile.backgroundColor = UIColor.red
    }
    
}

extension ProfileVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

