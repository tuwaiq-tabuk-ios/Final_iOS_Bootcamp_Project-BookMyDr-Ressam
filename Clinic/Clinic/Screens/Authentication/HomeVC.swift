//
//  HomeVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 09/05/1443 AH.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print("Uid \(K.FireStore.userId)")
  }
  
  @IBAction func logOutButtonTapped(_ sender: Any) {
    try?  Auth.auth().signOut()
    
    let homeViewController = self.storyboard?
      .instantiateViewController(identifier: K.Storyboard.loginController)
    
    self.view.window?.rootViewController = homeViewController
    self.view.window?.makeKeyAndVisible()
  }
  
}
