//
//  RestrictionsViewController.swift
//  MapWatch 2
//
//  Created by Joe Suzuki on 11/11/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase

class RestrictionsViewController: UIViewController {

    let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.allowsSelection = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setUpNavigationBar() {
        navigationItem.title = "Restrictions"
    }
    
    func k() {
        
    }


}
