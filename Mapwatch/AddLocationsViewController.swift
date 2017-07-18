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
    
    // Map
    @IBAction func searchButton(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var map: MKMapView!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { // when search
        UIApplication.shared.beginIgnoringInteractionEvents() // ignore activitys when using map
        let activityIndicator = UIActivityIndicatorView() // makes the pin
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        searchBar.resignFirstResponder() //hides search bar
        dismiss(animated: true, completion: nil)
        
        //search request *** use yelps api
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
