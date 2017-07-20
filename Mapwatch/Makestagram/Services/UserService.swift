//
//  UserService.swift
//  Makestagram
//
//  Created by Joe Suzuki on 7/11/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

// communicates between backend & UI

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase


struct UserService {
    // insert user-related networking code here
    static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let user = User(snapshot: snapshot) else {
                return completion(nil)
            }

            
            completion(user)
        })
    }
    static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void) {
        let userAttrs = ["username": username]
        
        let ref = Database.database().reference().child("users").child(firUser.uid)
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
           
        
        //        var nameed = ["name": name]
//        var addres = ["address": address]
//        var nameddd = ref.child(name)
//        var add = ref.child(address)
//        // 4
//        nameddd.setValue(name)
//        add.setValue(address)
        
    static func posts(for user: User, completion: @escaping ([Post]) -> Void) {
        let ref = Database.database().reference().child("posts").child(user.uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion([])
            }
            
            let dispatchGroup = DispatchGroup()
            
            let posts: [Post] =
                snapshot
                    .reversed()
                    .flatMap {
                        guard let post = Post(snapshot: $0)
                            else { return nil }
                        
                        dispatchGroup.enter()
                        return post
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                completion(posts)
            })
        })
    }
}
