//
//  AdminHomeVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 03/06/1443 AH.
//

import UIKit
import Firebase

class AdminHomeVC :UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    print("This Admin View")
  }
  
  
  @IBAction func logOutButton(_ sender: Any) {
    try?  Auth.auth().signOut()
    
    let homeViewController = self.storyboard?
      .instantiateViewController(identifier: K.Storyboard.logOutController)
    
    self.view.window?.rootViewController = homeViewController
    self.view.window?.makeKeyAndVisible()
  }
  }

