//
//  ViewController.swift
//  MapWatch 2
//
//  Created by Joe Suzuki on 10/8/1/Users/Joesuzuki/Desktop/MapWatch 2/MapWatch 27.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        // detects if user is not logged in
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async(execute: {
                self.handleLogout() //preform(#selector(handleLogout), withObject: nil, afterDelay: 0)
            })
        }
    }
    
    // MARK: functions
    
    func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: nil)
    }

}

