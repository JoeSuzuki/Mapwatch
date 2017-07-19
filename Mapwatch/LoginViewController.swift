////
////  LoginViewController.swift
////  Mapwatch
////
////  Created by Joe Suzuki on 7/19/17.
////  Copyright © 2017 JoeSuzuki. All rights reserved.
////
//
//import UIKit
//import FirebaseAuth
//import FirebaseAuthUI
//import Firebase
//import FirebaseDatabase
//
//
//class LoginViewController: UIViewController{
//    typealias FIRUser = FirebaseAuth.User
//
//    @IBOutlet weak var signUpButton: UIButton!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//    
//    @IBAction func signUpButtonTapped(_ sender: UIButton) {
//        
//        guard let authUI = FUIAuth.defaultAuthUI()
//            else { return }
//        
//        // 2
//        authUI.delegate = self
//        
//        // 3
//        let authViewController = authUI.authViewController()
//        present(authViewController, animated: true)
//    }
//    
//}
//extension LoginViewController: FUIAuthDelegate {
//    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
//        if let error = error {
//            assertionFailure("Error signing in: \(error.localizedDescription)")
//            return
//        }
//        // 1
//        guard let user = user
//            else { return }
//        
//        // 2
//        let userRef = Database.database().reference().child("users").child(user.uid)
//        
//        // 3
//        
//        
//        
//        userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
//            if let user = User(snapshot: snapshot) {
//                User.setCurrent(user)
//                
//                let storyboard = UIStoryboard(name: "Main", bundle: .main)
//                if let initialViewController = storyboard.instantiateInitialViewController() {
//                    self.view.window?.rootViewController = initialViewController
//                    self.view.window?.makeKeyAndVisible()
//                }
//            } else {
//                self.performSegue(withIdentifier: "toCreateUsername", sender: self)
//            }
//        })
//    }
//}
//
