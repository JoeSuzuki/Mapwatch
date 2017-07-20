//
//  MapViewController.swift
//  Mapwatch
//
//  Created by Joe Suzuki on 7/18/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import STLocationRequest

class MapViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    func presentLocationRequestController(){
        let locationRequestController = STLocationRequestController.getInstance()
        locationRequestController.titleText = "We need your location for some awesome features"
        locationRequestController.allowButtonTitle = "Alright"
        locationRequestController.notNowButtonTitle = "Not now"
        locationRequestController.mapViewAlpha = 0.9
        locationRequestController.backgroundColor = UIColor.lightGray
        locationRequestController.authorizeType = .requestWhenInUseAuthorization
        locationRequestController.present(onViewController: self)
    }
    
    
    
    
    // Map
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var adressLabel: UILabel!
    
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        
        self.map.showsUserLocation = true
        print("coordinate")
        print(location.coordinate)

        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil
            {
                print ("You messed up")
            }
            else
            {
                if let place = placemark?[0]
                {
                    if let checker = place.subThoroughfare
                    {
                        self.adressLabel.text = "\(place.subThoroughfare!) \n \(place.thoroughfare!) \n \(place.country!)"
                    }
                }
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.startUpdatingLocation()
        manager.desiredAccuracy = kCLLocationAccuracyBest // accurate location
        manager.requestWhenInUseAuthorization() // when used
        manager.startUpdatingLocation()
    }
    
}

extension MapViewController: STLocationRequestControllerDelegate {
    
    /// STLocationRequest Delegate Methods
    func locationRequestControllerDidChange(_ event: STLocationRequestControllerEvent) {
        switch event {
        case .locationRequestAuthorized:
            print("The user accepted the use of location services")
            self.locationManager.startUpdatingLocation()
            break
        case .locationRequestDenied:
            print("The user denied the use of location services")
            break
        case .notNowButtonTapped:
            print("The Not now button was tapped")
            break
        case .didPresented:
            print("STLocationRequestController did presented")
            break
        case .didDisappear:
            print("STLocationRequestController did disappear")
            break
        }
    }
    
}



