//
//  Protocols.swift
//  SpeechNote
//
//  Created by Erencan Evren on 1.06.2018.
//  Copyright © 2018 Cemal Bayrı. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import Firebase

@objc protocol BaseDBProcess {
    @objc optional func get()
    @objc optional func add()
    
}

protocol DBProcess: BaseDBProcess {
    func add<T>(_ collection: String, object: T, completion: @escaping(Bool, String) -> ())
    func get(_ collectionName: String, completion: @escaping([QueryDocumentSnapshot]?) ->())
    func delete(_ id: String, collectionName: String, completion: @escaping (Bool)->())
    func update(_ collectionName: String, documentName: String, data: [AnyHashable: Any], completion: @escaping (Bool) -> ())
    func getWith(_ collectionName: String, _ id: String, _ completion: @escaping([QueryDocumentSnapshot]?) -> ())
}

extension DBProcess {
    
}
