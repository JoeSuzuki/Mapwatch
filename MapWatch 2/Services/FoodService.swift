//
//  FoodService.swift
//  MapWatch 2
//
//  Created by Joe Suzuki on 11/4/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

struct FoodService {
   
    private var restrictionsRef: DatabaseReference!

    mutating func getDataFromFirebase(_ tableData: [String], completion: @escaping ([String]) -> ()) { 
        let uid = Auth.auth().currentUser?.uid
        var dataArray = tableData
        restrictionsRef = Database.database().reference().child("restrictions").child(uid!)
        restrictionsRef.observe(DataEventType.value, with: { (snapshot) in
            let restrictions = snapshot.value as? [String] ?? []
            dataArray = restrictions
            print(dataArray)
            completion(dataArray)
        })
    }
    
    mutating func createFoodRestrictions(_ foodRestriction: String, _ tableData: [String]) {
        let uid = Auth.auth().currentUser?.uid
        var dataArray = tableData
        restrictionsRef = Database.database().reference().child("restrictions").child(uid!)
        dataArray.append(foodRestriction)
        restrictionsRef.setValue(dataArray)
    }

}
