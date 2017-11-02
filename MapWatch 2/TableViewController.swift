//
//  TableViewController.swift
//  MapWatch 2
//
//  Created by Joe Suzuki on 10/31/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase

class HomeViewControllers: UITableViewController {
    var tableData: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
//        tableData = []
       // self.loadRestrictionsOnTable()
        let tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
       
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor(r: 76, g: 217, b: 100)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(mapView)) //addRestraintToTable
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadRestrictionsOnTable()
        
    }
    
    func loadRestrictionsOnTable() {
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("restrictions").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            self.tableData = []
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let lazyMapCollection = dictionary.keys // takes all the keys from firebase
                let stringArray = Array(lazyMapCollection.map { String($0) })
                print(stringArray)
                self.tableData = stringArray as! [String] + self.tableData
                print("ss\(self.tableData)")
                self.tableView.reloadData()
            }
        }, withCancel: nil)
    }
    
    // MARK: functions
//    func addRestraintToTable() {
//        if let input = inputTextField.text {
//            print(input)
//            
//            var ref: DatabaseReference!
//            let uid = Auth.auth().currentUser?.uid
//            ref = Database.database().reference()
//            let userRef = ref.child("restrictions").child(uid!)
//            
//            let values = tableData //set the values of email and password
//            
//            userRef.setValue(values, withCompletionBlock: { (err, ref) in
//                if err != nil {
//                    print(err)
//                    return
//                }
//            })
//        }
//    }
    
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
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        cell.textLabel?.textColor = UIColor(r: 76, g: 217, b: 100)
        cell.textLabel?.text = tableData[indexPath.row]
        
        return cell
    
    }


}
