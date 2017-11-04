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
        
        tableData = restrictionService.getDataFromFirebase(tableData)
        
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor(r: 76, g: 217, b: 100)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(mapView))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        self.view.addSubview(tableView)
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
            print("works bitttchhh")
        } else if indexPath.row == tableData.count + 1 {
            print("works")
            cell.textLabel?.text = "Add Restriction"
            restrictionService.createFoodRestrictions("sss", tableData)
        } else {
            cell.textLabel?.text = tableData[indexPath.row]
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
