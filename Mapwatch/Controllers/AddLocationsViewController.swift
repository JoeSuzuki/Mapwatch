//
//  AddLocationsViewController.swift
//  Mapwatch
//
//  Created by Joe Suzuki on 7/18/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation


class AddLocationsViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate,UISearchBarDelegate {
    var businessess: [Business?] = []
    var locationManager = CLLocationManager()
    var searchController: UISearchController!
    var searchText: String = ""
    let manager = CLLocationManager()
    
    @IBOutlet weak var addressLabel: UILabel!
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
                        self.addressLabel.text = "\(place.subThoroughfare!) \n \(place.thoroughfare!) \n \(place.country!) "
                    }
                }
            }
        }
    }

    
    
    // Map
    @IBAction func searchButton(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
        searchController.searchBar.placeholder = "e.g. tacos, fries, Max's"

    }
    
    @IBOutlet weak var map: MKMapView!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Ignoring user
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //Activity Indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        //Hide search bar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //Create the search request
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil {
                print("ERROR")
            }
            else {
                //Remove annotations
                let annotations = self.map.annotations
                self.map.removeAnnotations(annotations)
                
                //Getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.map.addAnnotation(annotation)
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegionMake(coordinate, span)
                self.map.setRegion(region, animated: true)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.desiredAccuracy = kCLLocationAccuracyBest // accurate location
        manager.requestWhenInUseAuthorization() // when used
        manager.startUpdatingLocation()

    }
    @IBAction func addButton(_ sender: UIButton) {
        //button pressed, want to send to firebase to table view
    }
}

            
