//
//  UserService.swift
//  Mapwatch
//
//  Created by Joe Suzuki on 7/19/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth.FIRUser
import FirebaseDatabase
import FirebaseAuth


//struct UserService {
//    static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void) {
//        let userAttrs = ["username": username]
//        
//        let ref = Database.database().reference().child("users").child(firUser.uid)
//        ref.setValue(userAttrs) { (error, ref) in
//            if let error = error {
//                assertionFailure(error.localizedDescription)
//                return completion(nil)
//            }
//            
//            ref.observeSingleEvent(of: .value, with: { (snapshot) in
//                let user = User(snapshot: snapshot)
//                completion(user)
//            })
//        }
//    }
//}
