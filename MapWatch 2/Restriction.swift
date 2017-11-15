//
//  Restriction.swift
//  MapWatch 2
//
//  Created by Joe Suzuki on 11/13/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class Restriction {
    var name: [String]
    
    init?(snapshot: DataSnapshot, name: [String]) {
        guard !snapshot.key.isEmpty,
            let dict = snapshot.value as? [String : Any],
            let name = dict["restriction"] as? [String]
            else { return nil }
        
        self.name = name
    }
    
}
