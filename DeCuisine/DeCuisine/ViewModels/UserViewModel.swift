//
//  UserViewModel.swift
//  SpeechNote
//
//  Created by Erencan Evren on 31.05.2018.
//  Copyright © 2018 Cemal Bayrı. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import Firebase

class UserViewModel {
    let db = DBViewModel(.firebase)
    var user: User?
    var mail: String = ""
    var password: String = ""
    
    init() {
    }
    
    required init(mail: String, pass: String) {
        self.mail = mail
        self.password = pass
    }
    
    func getUser(_ completion: @escaping (Bool) -> ()) {
        db.get("User") { (data) in
            if let data = data {
                let userData = data.filter{$0["email"] as! String == self.mail && $0["password"] as! String == self.password }.first
                if let data = userData {
                    self.user = self.createUser(data.data())
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
    
    func addUser(_ data: [String: Any], _ completion: @escaping (Bool) -> ()) {
        db.add("User", data: data) { (result,refId) in
            if result {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    
    private func createUser(_ data: [String: Any]?) -> User? {
        if let data = data {
            let user = User(data["name"] as! String, data["surname"] as! String, data["email"] as! String, data["isDeleted"] as! Int, data["password"] as! String, data["userId"] as! String, data["imageUrl"] as! String)
            return user
        } else {
            return nil
        }
    }
    
    func getPass(for mail: String, completion: @escaping (String) -> ()) {
        db.get("User") { (data) in
            if let data = data {
                let pass = data.filter{$0["mail"] as! String == mail}.first?.get("password")
                completion(pass as! String)
            } else {
                completion("")
            }
        }
    }
    
    
}
