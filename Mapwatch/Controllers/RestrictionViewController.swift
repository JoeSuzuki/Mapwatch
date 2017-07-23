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
  //  func CreateRes(_ address: String){
 //   var ref: DatabaseReference!
  //  ref = Database.database().reference()
    //    self.ref?.child("users").child("Restruants").setValue(["Locations": address])
   // }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true;
    }

    var posts = [Post]()
     var businesses: [Business]!
    var ref:DatabaseReference?
    var search: String?
    
    @IBOutlet weak var searchBar: UITextField?
    
    @IBAction func addButton(_ sender: UIButton) {
        guard let search = searchBar?.text else {
            return
        }
        Business.searchWithTerm(term: "pizza", completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            if let businesses = businesses {
                for business in businesses {
                    
                    //self.ref = Database.database().reference().child("users")
                    //self.ref?.child("restraunts").setValue(business.address)
                    //print(business.address)
                    //self.CreateRes(business.address!)
                }
            }
        }
        )
        
    }


override func viewDidLoad() {
        ref = Database.database().reference().child("users")
        super.viewDidLoad()
        //ref?.child("restraunts").child(user.uid).setValue("")

    }}








