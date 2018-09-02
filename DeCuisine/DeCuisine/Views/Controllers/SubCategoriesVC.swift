//
//  SubCategoriesVC.swift
//  DeCuisine
//
//  Created by Erencan Evren on 31.08.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import UIKit

class SubCategoriesVC: UIViewController {
    
    var subCategoryViewModel = SubCategoriesViewModel()
    let db = DBViewModel(DBType.firebase)
    var categoryId: String = "" {
        didSet {
            subCategoryViewModel.categoryId = categoryId
        }
    }
    var categoryName: String = "" {
        didSet {
            self.title = self.categoryName
        }
    }
    
    @IBOutlet weak var tbSubCategories: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadSubCategories()
    }
    
    private func setupTableView() {
        tbSubCategories.delegate = self
        tbSubCategories.dataSource = self
        tbSubCategories.tableFooterView = UIView()
       //tbSubCategories.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "subcategory")
    }
    
    func loadSubCategories() {
        subCategoryViewModel.getSubCategories { (result) in
            if result {
                self.tbSubCategories.reloadData()
            }
        }
    }

}

extension SubCategoriesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategoryViewModel.getSubCategoryCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbSubCategories.dequeueReusableCell(withIdentifier: "subcategory", for: indexPath) as! CategoryCell
        subCategoryViewModel.fill(cell, indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if subCategoryViewModel.getSubCategoryCount() != 0 {
            return self.tbSubCategories.frame.height / CGFloat(subCategoryViewModel.getSubCategoryCount())
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "main", sender: nil)
    }
    
}
