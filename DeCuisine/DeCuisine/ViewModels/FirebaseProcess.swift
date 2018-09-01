//
//  FirebaseProcess.swift
//  SpeechNote
//
//  Created by Erencan Evren on 1.06.2018.
//  Copyright © 2018 Cemal Bayrı. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import Firebase

class FirebaseProcess: DBProcess {
  
    func delete(_ id: String, collectionName: String, completion: @escaping (Bool) -> ()) {
        
    }
    
    
    private var ref: DocumentReference? = nil
    func getWith(_ collectionName: String, _ id: String, _ completion: @escaping ([QueryDocumentSnapshot]?) -> ()) {
        db.collection(collectionName).whereField("categoryId", isEqualTo: id).getDocuments { (querySnap, error) in
            Loading.hide()
            self.conclusion(error, { (result) in
                if result {
                    for doc in querySnap!.documents {
                        print("\(doc.documentID) --> \(doc.data())")
                    }
                    completion(querySnap?.documents)
                } else {
                    completion(nil)
                }
            })
        }
    }
    
    func get(_ collectionName: String, completion: @escaping ([QueryDocumentSnapshot]?) -> ()) {
        Loading.show()
        db.collection(collectionName).getDocuments() { (querySnap, error) in
            Loading.hide()
            self.conclusion(error, { (result) in
                if result {
                    for doc in querySnap!.documents {
                        print("\(doc.documentID) --> \(doc.data())")
                    }
                    completion(querySnap?.documents)
                } else {
                    completion(nil)
                }
            })
        }
    }
    
    func add<T>(_ collectionName: String, object: T, completion: @escaping (Bool, String) -> ()) {
        Loading.show()
        ref = db.collection(collectionName).addDocument(data: object as! [String: Any]) {
            err in
            Loading.hide()
            self.conclusion(err, { result in
                if result {
                    print("Document added with ID: \(self.ref!.documentID)")
                    completion(true, self.ref!.documentID)
                }
            })
        }
    }
    
    func update(_ collectionName: String, documentName: String, data: [AnyHashable: Any], completion: @escaping (Bool) -> ()) {
        ref = db.collection(collectionName).document(documentName)
        ref?.updateData(data, completion: { (err) in
            self.conclusion(err, { (result) in
                result ? completion(true) : completion(false)
            })
        })
    }

    
    private func conclusion(_ err: Error?, _ completion: (Bool) -> ()) {
        if let err = err {
            print(err.localizedDescription)
            completion(false)
        } else {
            completion(true)
        }
    }
}
