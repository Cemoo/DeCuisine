//
//  User.swift
//  DeCuisine
//
//  Created by Erencan Evren on 16.08.2018.
//  Copyright © 2018 Cemal BAYRI. All rights reserved.
//

import Foundation

class User {
    var name: String?
    var surname: String?
    var isDeleted: Int?
    var mail: String?
    var pass: String?
    var id: String?
    var imageUrl: String?
    
    var arr: [String: Any] = [:]
    
    init(_ name: String, _ surname: String, _ mail: String, _ isDeleted: Int, _ pass: String, _ id: String, _ url: String) {
        self.name = name
        self.surname = surname
        self.isDeleted = isDeleted
        self.mail = mail
        self.pass = pass
        self.id = id
        self.imageUrl = url
    }
    
    func request() -> [String: Any] {
        arr["name"] = self.name?.trimmingCharacters(in: .whitespacesAndNewlines)
        arr["surname"] = self.surname?.trimmingCharacters(in: .whitespacesAndNewlines)
        arr["isDeleted"] = self.isDeleted
        arr["mail"] = self.mail?.trimmingCharacters(in: .whitespacesAndNewlines)
        arr["password"] = self.pass?.trimmingCharacters(in: .whitespacesAndNewlines)
        arr["userId"] = self.id
        arr["imageUrl"] = self.imageUrl?.trimmingCharacters(in: .whitespacesAndNewlines)
        return arr
    }
    
    
}
