//
//  RestrictionsViewController.swift
//  MapWatch 2
//
//  Created by Joe Suzuki on 11/11/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase

class RestrictionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let cellId = "cellId"
    
    let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.allowsSelection = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpTableView()
    }
    
    func setUpNavigationBar() {
        navigationItem.title = "Restrictions"
//        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellContent.self, forCellReuseIdentifier: cellId)

        view.addSubview(tableView)
        
//        //x, y, width, height
//        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
//        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
//        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CellContent
        cell.pictureImageView.image = UIImage(named: "Bulb 2")
        cell.titleLabel.text = "kjj"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }


}
class CellContent: UITableViewCell {
    
    let cellView: UIView = { // create cell
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let pictureImageView: UIImageView = { // create imageview
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = { //  sets cell label
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) { // setup the tableview cell data
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    func setup() {
        backgroundColor = UIColor(r: 245, g: 245, b: 245)
        addSubview(cellView)
        cellView.addSubview(pictureImageView)
        cellView.addSubview(titleLabel)
        
//        //x, y, width, height
//        cellView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
//        cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4).isActive = true
//        cellView.rightAnchor.constraint(equalTo: rightAnchor, constant: 8).isActive = true
//        cellView.topAnchor.constraint(equalTo: topAnchor, constant:4).isActive = true
//
//        //x, y, width, height
//        pictureImageView.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 8).isActive = true
//        pictureImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        pictureImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        pictureImageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
//
//        //x, y, width, height
//        titleLabel.leftAnchor.constraint(equalTo: pictureImageView.rightAnchor, constant: 20).isActive = true
//        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 20).isActive = true
//        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        titleLabel.centerYAnchor.constraint(equalTo: pictureImageView.centerYAnchor).isActive = true
        
        cellView.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 8, paddingBottom: 4, paddingRight: 8)
        
        pictureImageView.setAnchor(top: nil, left: cellView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        pictureImageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
        titleLabel.setAnchor(top: nil, left: pictureImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, height: 40)
        titleLabel.centerYAnchor.constraint(equalTo: pictureImageView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


