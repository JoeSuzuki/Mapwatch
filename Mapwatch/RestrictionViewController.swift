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
    var posts = [Post]()
    let refreshControl = UIRefreshControl()
     var businesses: [Business]!
    var ref:DatabaseReference?

    
    
    @IBOutlet weak var searchBar: UITextField!
    @IBAction func textBar(_ sender: UITextField) {
        }
    
    @IBAction func addButton(_ sender: UIButton) {
        if searchBar.text != "" {
            Business.searchWithTerm(term: searchBar.text!, completion: { (businesses: [Business]?, error: Error?) -> Void in
                self.businesses = businesses
                if let businesses = businesses {
                    for business in businesses {
                       // print(business.name!)
                        //print(business.address!)
                    }
                }
            }
            )}}
override func viewDidLoad() {
        ref = Database.database().reference()
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        
    
        }}

}






