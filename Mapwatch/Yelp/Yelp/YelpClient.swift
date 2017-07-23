//
//  YelpClient.swift
//  Mapwatch
//
//  Created by Joe Suzuki on 7/19/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//


import UIKit

import AFNetworking
import BDBOAuth1Manager

// You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
let yelpConsumerKey = "ebuWfq-48mkwD5QCQG5RPQ"
let yelpConsumerSecret = "VE74b0iUmNPmO7hhXI80GQv9OfKjBJQjtBC8E1Z4xDqrd5xXMOG4jQU4S9H8KpX7"
let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"

enum YelpSortMode: Int {
    case bestMatched = 0, distance, highestRated
}

class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!
    
    //MARK: Shared Instance
    
    static let sharedInstance = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        let baseUrl = URL(string: "https://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        let token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(_ term: String, completion: @escaping ([Business]?, Error?) -> Void) -> AFHTTPRequestOperation {
        return searchWithTerm(term, offset: nil, latitude: nil, longitude: nil, sort: nil, categories: nil, deals: nil, completion: completion)
    }
    
    func searchWithTerm(_ term: String, offset: Int?, latitude: Double?, longitude: Double?, sort: YelpSortMode?, categories: [String]?, deals: Bool?, completion: @escaping ([Business]?, Error?) -> Void) -> AFHTTPRequestOperation {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        
        // Default the location to San Francisco
        var parameters: [String : AnyObject] = ["term": term as AnyObject, "ll": "37.785771,-122.406165" as AnyObject]
        
        if let latitude = latitude {parameters["ll"] = "37.785771,-122.406165" as AnyObject
            parameters["ll"] = "\(latitude),\(longitude!)" as AnyObject
        } else {
            parameters["ll"] = "37.785771,-122.406165" as AnyObject
        }
        
        if let offset = offset {
            parameters["offset"] = offset as AnyObject
        }
        
        if sort != nil {
            parameters["sort"] = sort!.rawValue as AnyObject?
        }
        
        if categories != nil && categories!.count > 0 {
            parameters["category_filter"] = (categories!).joined(separator: ",") as AnyObject?
        }
        
        if deals != nil {
            parameters["deals_filter"] = deals! as AnyObject?
        }
        
        print(parameters)
        
        return self.get("search", parameters: parameters,
                        success: { (operation: AFHTTPRequestOperation, response: Any) -> Void in
                            if let response = response as? [String: Any]{
                                let dictionaries = response["businesses"] as? [NSDictionary]
                                if dictionaries != nil {
                                    completion(Business.businesses(array: dictionaries!), nil)
                                }
                            }
        },
                        failure: { (operation: AFHTTPRequestOperation?, error: Error) -> Void in
                            completion(nil, error)
        })!
    }
}
