//
//  TableViewController.swift
//  Mapwatch
//
//  Created by Joe Suzuki on 7/19/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import Foundation

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var list = ["Milk", "Honey", "Bread", "Tacos", "Tomatoes"]
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return(list.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        
        return(cell)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

