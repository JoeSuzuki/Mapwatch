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

class RestrictionViewController: UIViewController {
    
    @IBAction func textBar(_ sender: UITextField) {
        
    }
//    @IBAction func addButton(_ sender: UIButton) {
//        TableViewController().list.append(sender.text!)
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
  
}

            
