//
//  HomeViewController.swift
//  MapWatch 2
//
//  Created by Joe Suzuki on 10/31/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController{
    
    var tableData: [String] = []
    var tableView = UITableView()
    var restrictionService = FoodService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restrictionService.getDataFromFirebase(tableData) { (dataArray) -> () in
            self.tableData = dataArray
            self.tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            
            self.view.addSubview(self.tableView)
        }
        
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.textColor = UIColor(r: 76, g: 200, b: 100)
        
        if indexPath.row == tableData.count {
        } else if indexPath.row == tableData.count + 1 {
            cell.textLabel?.text = "Add Restriction"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = UIColor.white
            cell.backgroundColor = UIColor(r: 76, g: 200, b: 100)
        } else {
            cell.textLabel?.text = tableData[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == tableData.count + 1 {
            return 60
        } else {
            return 50
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == tableData.count {
            print("works bitttchhh")
        } else if indexPath.row == tableData.count + 1 {
            restrictionService.createFoodRestrictions("sddmmsaaass", tableData)
        }
    }
   // func tableview
}
