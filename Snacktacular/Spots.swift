//
//  Spots.swift
//  Snacktacular
//
//  Created by Jacob Wang on 3/31/21.
//

import Foundation
import Firebase

class Spots {
    var spotsArray: [Spot] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("spots").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.spotsArray = [] //clean out existing spotArray since new data will load
            //there are querySnapshot!.documents.count documents in the snapshot
            for document in querySnapshot!.documents {
                //You'll have to make sure that you have a dictionary initializer in the singular class
                let spot = Spot(dictionary: document.data())
                spot.documentID = document.documentID
                self.spotsArray.append(spot)
            }
            completed()
        }
    }
}
