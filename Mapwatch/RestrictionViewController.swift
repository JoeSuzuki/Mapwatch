//
//  RestrictionViewController.swift
//  Mapwatch
//
//  Created by Joe Suzuki on 7/19/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class RestrictionViewController: UIViewController {
    func CreateRes(_ address: String){
    var ref: DatabaseReference!
    ref = Database.database().reference()
        self.ref?.child("users").child("Restruants").setValue(["Locations": address])
    }

    var posts = [Post]()
     var businesses: [Business]!
    var ref:DatabaseReference?
    var search: String?
    
    @IBOutlet weak var searchBar: UITextField!
    
    @IBAction func addButton(_ sender: UIButton) {
        guard let search = searchBar.text else {
            return
        }
        Business.searchWithTerm(term: search, completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            if let businesses = businesses {
                for business in businesses {
                    self.CreateRes(business.address!)
                }
            }
        }
        )
        
    }


override func viewDidLoad() {
        ref = Database.database().reference()
        super.viewDidLoad()
       // ref?.child("users").child(User.uid).child("Restraunts").setValue("")

    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }}








