//
//  BaseCategory.swift
//  DeCuisine
//
//  Created by Erencan Evren on 31.08.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import Foundation

class BaseCategory {
    var name: String?
    var url: String?
    var id: String?
    
    var arr: [String: Any] = [:]
    
    init(_ name: String, _ url: String, _ id: String) {
        self.name = name
        self.id = id
        self.url = url
    }
    
    func request() -> [String: Any] {
        arr["name"] = self.name?.trimmingCharacters(in: .whitespacesAndNewlines)
        arr["url"] = self.url?.trimmingCharacters(in: .whitespacesAndNewlines)
        arr["id"] = self.id?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return arr
    }
}
