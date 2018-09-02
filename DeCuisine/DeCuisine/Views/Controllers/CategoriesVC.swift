//
//  CategoriesVC.swift
//  DeCuisine
//
//  Created by Erencan Evren on 31.08.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import UIKit

class CategoriesVC: UIViewController {
    
    
    var categoryModel = CategoriesViewModel()
    var catId: String = ""
    var categoryName: String = "" {
        didSet {
            let dest = UIStoryboard(name: "Category", bundle: nil).instantiateViewController(withIdentifier: "SubCategoriesVC") as! SubCategoriesVC
            dest.categoryId = self.catId
            dest.categoryName = self.categoryName
            self.navigationController?.pushViewController(dest, animated: true)
        }
    }
    
    @IBOutlet weak var tbCategories: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadCategories()
    }
    
    private func setupTableView() {
        tbCategories.delegate = self
        tbCategories.dataSource = self
    }

    func loadCategories() {
        Loading.show()
        categoryModel.getCategories { result in
            Loading.hide()
            if result {
                self.tbCategories.reloadData()
            }
        }
    }

}

extension CategoriesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryModel.getCategoryCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbCategories.dequeueReusableCell(withIdentifier: "category", for: indexPath) as! CategoryCell
        categoryModel.fill(cell, indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if categoryModel.getCategoryCount() != 0 {
            return self.tbCategories.frame.height / CGFloat(categoryModel.getCategoryCount())
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.catId = categoryModel.getCategoryId(indexPath.row)
        self.categoryName = categoryModel.getCategoryName(indexPath.row)
        
    }
    
}
