//
//  BusinesssAnotation.swift
//  Yelp
//
//  Created by Siraj Zaneer on 2/12/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class BusinesssAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var business: Business!
    var title: String?
    var index: Int!
    
    init(title: String, coordinate: CLLocationCoordinate2D, business: Business, index: Int) {
        self.coordinate = coordinate
        self.business = business
        self.index = index
        self.title = title
    }

}
