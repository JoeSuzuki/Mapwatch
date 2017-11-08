//
//  CustomTabBarController.swift
//  MapWatch 2
//
//  Created by Joe Suzuki on 11/7/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let mapController = MapViewController()
        let mapNavController = UINavigationController(rootViewController: mapController)
        mapNavController.tabBarItem.image = UIImage(named: "")
        mapNavController.tabBarItem.title = "Map"
        
        let homeController = HomeViewController()
        let homeNavController = UINavigationController(rootViewController: homeController)
        homeNavController.tabBarItem.image = UIImage(named: "")
        homeNavController.tabBarItem.title = "Settings"
     
        let profileController = ProfileViewController()
        let profileNavController = UINavigationController(rootViewController: profileController)
        profileNavController.tabBarItem.image = UIImage(named: "")
        profileNavController.tabBarItem.title = "Settings"

        viewControllers = [mapNavController, homeNavController, profileNavController]
    }

}
