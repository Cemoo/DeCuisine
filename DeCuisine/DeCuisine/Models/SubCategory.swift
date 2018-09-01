//
//  SubCategory.swift
//  DeCuisine
//
//  Created by Erencan Evren on 31.08.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import Foundation

class SubCategory: BaseCategory {
    var categoryId: String?
    
    required init(_ catId: String, _ name: String, _ url: String, _ id: String) {
        super.init(name, url, id)
        self.categoryId = catId
    }
    
    override func request() -> [String : Any] {
        arr["categoryId"] = self.categoryId?.trimmingCharacters(in: .whitespacesAndNewlines)
        return arr
    }
}
