//
//  ViewController.swift
//  MapWatch 2
//
//  Created by Joe Suzuki on 10/8/1/Users/Joesuzuki/Desktop/MapWatch 2/MapWatch 27.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableData: Array<Any> = []
    
    let ContainerView: UIView = {
        //setup
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    let restraintsTableView: UITableView = {
        let view = UITableView()
        view.delegate = self as? UITableViewDelegate
        view.dataSource = self as? UITableViewDataSource
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter food restrictions"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.setTitle("Add Restraint", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(r: 76, g: 217, b: 100), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(addRestraintToTable), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRestrictionsOnTable()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor(r: 76, g: 217, b: 100)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(mapView))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        view.backgroundColor = UIColor.white
        view.addSubview(ContainerView)
        setupContainerView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    
    func loadRestrictionsOnTable() {
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("restrictions").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            self.tableData = []
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let lazyMapCollection = dictionary.keys // takes all the keys from firebase
                let stringArray = Array(lazyMapCollection.map { String($0) })
                print(stringArray)
                self.tableData = stringArray + self.tableData
                print("ss\(self.tableData)")
                self.restraintsTableView.reloadData()
            }
        }, withCancel: nil)
    }
    
    // MARK: functions
    func setupContainerView() {
        //x, y, width, height
        ContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        ContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        ContainerView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        ContainerView.addSubview(restraintsTableView)
        ContainerView.addSubview(inputTextField)
        ContainerView.addSubview(addButton)
        
        //x, y, width, height
        restraintsTableView.leftAnchor.constraint(equalTo: ContainerView.leftAnchor).isActive = true
        restraintsTableView.topAnchor.constraint(equalTo: ContainerView.topAnchor).isActive = true
        restraintsTableView.widthAnchor.constraint(equalTo: ContainerView.widthAnchor).isActive = true
        restraintsTableView.heightAnchor.constraint(equalTo: ContainerView.heightAnchor, multiplier: 12/14).isActive = true

        //x, y, width, height
        inputTextField.leftAnchor.constraint(equalTo: ContainerView.leftAnchor, constant: 12).isActive = true
        inputTextField.topAnchor.constraint(equalTo: restraintsTableView.bottomAnchor).isActive = true
        inputTextField.widthAnchor.constraint(equalTo: ContainerView.widthAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: ContainerView.heightAnchor, multiplier: 1/14).isActive = true
        
        //x, y, width, height
        addButton.leftAnchor.constraint(equalTo: ContainerView.leftAnchor).isActive = true
        addButton.topAnchor.constraint(equalTo: inputTextField.bottomAnchor).isActive = true
        addButton.widthAnchor.constraint(equalTo: ContainerView.widthAnchor).isActive = true
        addButton.heightAnchor.constraint(equalTo: ContainerView.heightAnchor, multiplier: 1/14).isActive = true
        

    }
    func addRestraintToTable() {
        if let input = inputTextField.text {

        var ref: DatabaseReference!
        let uid = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        let userRef = ref.child("restrictions").child(uid!)
        var restrictions = [String]()
        restrictions.append(input)
            
        let values = [input: input] //set the values of email and password
        userRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil {
                print(err)
                return
            }
        })
        }
        
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
    // MARK: - Table view data source
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableData.count
    }
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.textColor = UIColor(r: 76, g: 217, b: 100)
        cell.textLabel?.text = tableData[indexPath.row] as! String
        
        return cell
    }

}
