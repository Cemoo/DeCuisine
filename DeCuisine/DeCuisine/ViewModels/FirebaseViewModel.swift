//
//  FirebaseViewModel.swift
//  DeCuisine
//
//  Created by Erencan Evren on 30.05.2018.
//  Copyright © 2018 Cemal Bayrı. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import Firebase

class FirebaseViewModel {
    var ref: DocumentReference? = nil
    func add(_ collectionName: String, object: [String: Any]) {
        ref = db.collection(collectionName).addDocument(data: object) {
            err in
            self.conclusion(err, { result in
                if result {
                    print("Document added with ID: \(self.ref!.documentID)")
                }
            })
        }
    }
    
    func get(_ collectionName: String) {
        db.collection(collectionName).getDocuments() { (querySnap, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                for doc in querySnap!.documents {
                    print("\(doc.documentID) --> \(doc.data())")
                }
            }
        }
    }
    
    func conclusion(_ err: Error?, _ completion: (Bool) -> ()) {
        if let err = err {
            print(err.localizedDescription)
            completion(false)
        } else {
            completion(true)
        }
    }
}











