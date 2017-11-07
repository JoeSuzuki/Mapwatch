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
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor(r: 76, g: 217, b: 100)]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(mapView))
    }
    
    func mapView() {
        self.dismiss(animated: true, completion: nil)
    }
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
// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.textColor = UIColor(r: 76, g: 217, b: 100)
        
        if indexPath.row == tableData.count {
        } else if indexPath.row == tableData.count + 1 {
            cell.textLabel?.text = "Add Restriction"
        } else {
            cell.textLabel?.text = tableData[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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
