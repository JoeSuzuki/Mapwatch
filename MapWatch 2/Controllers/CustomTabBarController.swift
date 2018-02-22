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
        
        let restrictionsController = RestrictionsViewController()
        let restrictionsNavController = UINavigationController(rootViewController: restrictionsController)
        restrictionsNavController.tabBarItem.image = UIImage(named: "")
        restrictionsNavController.tabBarItem.title = "Restrictions"
        
        let foodGroupsController = FoodGroupsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let foodGroupsNavController = UINavigationController(rootViewController: foodGroupsController)
        foodGroupsNavController.tabBarItem.image = UIImage(named: "")
        foodGroupsNavController.tabBarItem.title = "Food"

//        let homeController = GroupHomeController(collectionViewLayout: UICollectionViewFlowLayout())

        viewControllers = [mapNavController, homeNavController, restrictionsNavController, foodGroupsNavController, profileNavController]
    }

}
