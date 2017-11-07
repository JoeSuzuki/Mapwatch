//
//  MapViewController.swift
//  MapWatch 2
//
//  Created by Joe Suzuki on 10/29/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var locationManager: CLLocationManager?
    let distanceSpan: Double = 500 // range of the view in meters from users location

    let containerView: UIView = {
        //setup
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    let mapView: MKMapView = {
        let view = MKMapView()
        view.mapType = MKMapType.standard
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 249, g: 249, b: 249)
        button.setTitle("View Restraints", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(r: 76, g: 217, b: 100), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(backFunc), for: .touchUpInside)
        return button
    }()
    
    func backFunc() {
        let homeViewController = HomeViewController()
        let newController = UINavigationController(rootViewController: homeViewController)
        present(newController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 76, g: 217, b: 100)
        view.addSubview(containerView)
        view.addSubview(backButton)
        setupContainerView()
        checkIfUserIsLoggedOn()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor(r: 76, g: 217, b: 100)]
        self.locationManager = CLLocationManager() // sets the current location of user
        if let locationManager = self.locationManager {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestAlwaysAuthorization()
            locationManager.distanceFilter = 500
            locationManager.startUpdatingLocation()
        }
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor(r: 76, g: 217, b: 100)]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))

    }
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region, animated: true)
        
        self.mapView.showsUserLocation = true
    }
    func setupContainerView() {
        //x, y, width, height
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        containerView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0).isActive = true
        
        containerView.addSubview(mapView)
        containerView.addSubview(backButton)

        //x, y, width, height
        mapView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        mapView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 11/12).isActive = true

        //x, y, width, height
        backButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        backButton.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        backButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1/2).isActive = true
        backButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/12).isActive = true
    }
    func checkIfUserIsLoggedOn() {
        if Auth.auth().currentUser?.uid == nil {// detects if user is not logged in
            DispatchQueue.main.async(execute: {
                self.handleLogout()
            })
        } else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.navigationItem.title = dictionary["username"] as? String
                }
            }, withCancel: nil)
        }
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
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
