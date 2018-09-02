//
//  CategoriesViewModel.swift
//  DeCuisine
//
//  Created by Erencan Evren on 31.08.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import Foundation
import Firebase

class CategoriesViewModel {
    
    var categories: [Category]? = []
    let db = DBViewModel(.firebase)
    
    func getCategories(_ completion: @escaping (Bool) -> ()) {
        db.get("Category") { (catData) in
            if let categoryData = catData {
                categoryData.forEach({ (item) in
                    self.fetchData(with: item)
                })
                self.categories = self.categories?.reversed()
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func fetchData(with data: QueryDocumentSnapshot) {
        let data = Category(data["name"] as! String , data["url"] as! String, data.documentID)
        self.categories?.append(data)
    }
    
    func getCategoryCount() -> Int {
        guard let categories = self.categories else {
            return 0
        }
        
        return categories.count
    }
    
    func getCategoryName(_ row: Int) -> String {
        guard let categories = self.categories else {
            return ""
        }
        
        return categories[row].name ?? ""
    }
    
    func getCategoryId(_ row: Int) -> String {
        guard let categories = self.categories else {
            return ""
        }
        
        return categories[row].id ?? ""
    }
    
    func fill(_ cell: CategoryCell, _ row: Int) {
        guard let categories = self.categories else {return}
        cell.lblCategoryName.text = categories[row].name
        cell.imgBack.download(with: URL(string: categories[row].url!)!)
    }

}
