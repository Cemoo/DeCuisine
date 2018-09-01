//
//  DB.swift
//  DeCuisine
//
//  Created by Cemal Bayrı on 1.06.2018.
//  Copyright © 2018 Cemal Bayrı. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import Firebase

enum DBType {
    case firebase
    case amazon
}

class DBViewModel {
    var dbProcess: DBProcess!
    var db_type: DBType = DBType.firebase
    
    init(_ dbType: DBType = .firebase) {
        switch dbType {
        case .firebase:
            dbProcess = FirebaseProcess()
        default:
            break
        }
    }
    
    func getWith(_ collectionName: String, _ id: String, _ completion: @escaping ([QueryDocumentSnapshot]?) -> ()) {
        dbProcess.getWith(collectionName, id) { (data) in
            completion(data)
        }
    }
    
    func get(_ collectionName: String, completion: @escaping ([QueryDocumentSnapshot]?) -> ()) {
        dbProcess.get(collectionName) { (data) in
            completion(data)
        }
    }
    
    func add<T>(_ collectionName: String, data: T, completion: @escaping (Bool, String?) -> ()) {
        dbProcess.add(collectionName, object: data) { (result, id) in
            if result {
                completion(true, id)
            } else {
                completion(false, nil)
            }
        }
    }
    
    func delete(_ id: String, collectionName: String, completion: @escaping (Bool) -> ()) {
        dbProcess.delete(id, collectionName: collectionName) { (result) in
            if result {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func update(_ data: [AnyHashable: Any], docName: String, collectionName: String, completion: @escaping (Bool) -> ()) {
        dbProcess.update(collectionName, documentName: docName, data: data) { (result) in
            completion(result)
        }
    }
}
