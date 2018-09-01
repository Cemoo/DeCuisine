//
//  SubCategoriesViewModel.swift
//  DeCuisine
//
//  Created by Erencan Evren on 31.08.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import Foundation
import Firebase

class SubCategoriesViewModel {
    var subCategories: [SubCategory]? = []
    let db = DBViewModel(.firebase)
    
    func getCategories(_ completion: @escaping (Bool) -> ()) {
        db.get("SubCategory") { (catData) in
            if let categoryData = catData {
                categoryData.forEach({ (item) in
                    self.fetchData(with: item)
                })
                self.subCategories = self.subCategories?.reversed()
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func fetchData(with data: QueryDocumentSnapshot) {
        let data = SubCategory(data["categoryId"] as! String, data["name"] as! String, data["url"] as! String, data.documentID)
        self.subCategories?.append(data)
    }
    
    func getCategoryCount() -> Int {
        guard let subCategories = self.subCategories else {
            return 0
        }
        
        return subCategories.count
    }
    
    func fill(_ cell: CategoryCell, _ row: Int) {
        guard let subCategories = self.subCategories else {return}
        cell.lblCategoryName.text = subCategories[row].name
        cell.imgBack.download(with: URL(string: subCategories[row].url!)!)
    }
}
