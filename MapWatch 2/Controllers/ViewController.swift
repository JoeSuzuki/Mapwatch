//
//  ViewController.swift
//  MapWatch 2
//
//  Created by Joe Suzuki on 10/8/1/Users/Joesuzuki/Desktop/MapWatch 2/MapWatch 27.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    // MARK: functions
    
    func handleLogout() {
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: nil)
    }

}

