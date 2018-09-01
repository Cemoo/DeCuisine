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
    var categoryId: String = ""
    var categoryName: String = "" {
        didSet {
            self.title = self.categoryName
        }
    }
    
    @IBOutlet weak var tbSubCategories: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tbSubCategories.delegate = self
        tbSubCategories.dataSource = self
    }
    
    func loadSubCategories() {
        db
    }


}

extension SubCategoriesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategoryViewModel.getCategoryCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbSubCategories.dequeueReusableCell(withIdentifier: "subcategory", for: indexPath) as! CategoryCell
        subCategoryViewModel.fill(cell, indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if subCategoryViewModel.getCategoryCount() != 0 {
            return self.tbSubCategories.frame.height / CGFloat(subCategoryViewModel.getCategoryCount())
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
