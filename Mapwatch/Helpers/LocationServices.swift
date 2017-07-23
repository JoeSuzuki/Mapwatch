//
//  LocationServices.swift
//  Mapwatch
//
//  Created by Joe Suzuki on 7/20/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

struct LocationServices {
    private static func create(_ name: String, address: String) {
        // create new post in database
        // 1 Create a reference to the current user. We'll need the user's UID to construct the location of where we'll store our post data in our database.
        let currentUser = User.current
        
        // 1 We create references to the important locations that we're planning to write data.
        let rootRef = Database.database().reference()
        let newPostRef = rootRef.child("posts").child(currentUser.uid).childByAutoId()
        let newPostKey = newPostRef.key
        
        let postRef = Database.database().reference().child("posts").child(currentUser.uid).childByAutoId()
    }
    static func show(forKey postKey: String, posterUID: String, completion: @escaping (Post?) -> Void) {
        let ref = Database.database().reference().child("posts").child(posterUID).child(postKey)
        
    }}
