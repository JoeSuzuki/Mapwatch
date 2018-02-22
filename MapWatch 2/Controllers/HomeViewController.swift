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
    
    let addRestrictionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue //UIColor(r: 76, g: 200, b: 100)
        button.setTitle("Add Restraint", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitleColor(UIColor(r: 76, g: 200, b: 100), for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(addRestriction), for: .touchUpInside)
        return button
    }()
    
    func addRestriction() {
        restrictionService.createFoodRestrictions("sddmmsaaass", tableData)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        restrictionService.getDataFromFirebase(tableData) { (dataArray) -> () in
            self.tableData = dataArray
            self.tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            
//            self.view.addSubview(self.tableView)
            self.setUpTableView()
        }
        
    }
    func setUpTableView() {
        view.addSubview(tableView)
        view.addSubview(addRestrictionButton)
        
        //        //x, y, width, height
        //        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        //        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        //        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        //        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: addRestrictionButton.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        addRestrictionButton.setAnchor(top: tableView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
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
            cell.textLabel?.textColor = .white
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
            print("works ")
        } else if indexPath.row == tableData.count + 1 {
            restrictionService.createFoodRestrictions("sddmmsaaass", tableData)
        }
    }
   // func tableview
}
