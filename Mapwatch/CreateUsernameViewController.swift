////
////  CreateUsernameViewController.swift
////  Mapwatch
////
////  Created by Joe Suzuki on 7/19/17.
////  Copyright © 2017 JoeSuzuki. All rights reserved.
////
//
//import UIKit
//import FirebaseAuth
//import FirebaseDatabase
//
//class CreateUsernameViewController: UIViewController {
//    
//    @IBOutlet weak var nextButton: UIButton!
//    @IBOutlet weak var usernameTextField: UITextField!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//    
//    @IBAction func nextButtonTapped(_ sender: UIButton) {
//        guard let firUser = Auth.auth().currentUser,
//            let username = usernameTextField.text,
//            !username.isEmpty else { return }
//        
//        UserService.create(firUser, username: username) { (user) in
//            guard let user = user else {
//                // handle error
//                return
//            }
//            
//            User.setCurrent(user)
//            
//            let storyboard = UIStoryboard(name: "Main", bundle: .main)
//            if let initialViewController = storyboard.instantiateInitialViewController() {
//                self.view.window?.rootViewController = initialViewController
//                self.view.window?.makeKeyAndVisible()
//            }
//        }
//    }
//}
