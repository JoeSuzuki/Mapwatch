//
//  Post.swift
//  Makestagram
//
//  Created by Joe Suzuki on 7/12/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import FirebaseDatabase.FIRDataSnapshot

class Post: MGKeyed {
    // properties and initializers
    var key: String?
    var name: String
    var address: String
       var dictValue: [String : Any] {
        let userDict = ["uid" : poster.uid,
                        "username" : poster.username]
        
        return ["name" : name,
                "address" : address,
                "poster" : userDict
                ]
    }
    

    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let name = dict["nameofRestraunt"] as? String,
            let address = dict["address"] as? String,
            let userDict = dict["poster"] as? [String : Any],
            let uid = userDict["uid"] as? String,
            let username = userDict["username"] as? String
            else { return nil }
        
        self.key = snapshot.key
        self.name = name
        self.address = address
        self.name = name
        self.address = address
        self.poster = User.current
    }
    let poster: User

}

