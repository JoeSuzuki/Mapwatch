//
//  MapViewController.swift
//  MapWatch 2
//
//  Created by Joe Suzuki on 10/29/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps

class MapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
   
    var locationManager = CLLocationManager()
    lazy var mapView = GMSMapView()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 76, g: 200, b: 100)
        button.setTitle("View Restraints", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(r: 76, g: 200, b: 100), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(backFunc), for: .touchUpInside)
        return button
    }()
    
    @objc func backFunc() {
        let homeViewController = HomeViewController()
        let newController = UINavigationController(rootViewController: homeViewController)
        present(newController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // view.backgroundColor = UIColor(r: 76, g: 217, b: 100)
        checkIfUserIsLoggedOn()
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 16.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.setMinZoom(15.0, maxZoom: 18)
        mapView.animate(toZoom: 15)
        mapView.delegate = self
        view = mapView

        // User Location
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        let center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        
        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude,
                                              longitude: userLocation!.coordinate.longitude, zoom: 13.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        self.view = mapView
        
        locationManager.stopUpdatingLocation()
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
                    guard let username = dictionary["username"] else {
                        return
                    }
            
                    self.navigationItem.title = "Welcome " + (username as! String) + "!"
                    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
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
}
