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
      
      navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "power.circle.fill"), style: .plain, target: self, action: #selector(logout))
  }
  
  @IBAction func doctorBtnTapped(_ sender: UIButton) {
      if  let homeViewController = self.storyboard?
            .instantiateViewController(identifier: "DoctorsTableVC") as? DoctorsTableVC{
    navigationController?.pushViewController(homeViewController, animated: true)
      }
  }
  
    @IBAction func location(_ sender: UIButton) {
        if  let homeViewController = self.storyboard?
              .instantiateViewController(identifier: "LocationClinicVC") as? LocationClinicVC{
      navigationController?.pushViewController(homeViewController, animated: true)
        }
        
    }
    @IBAction func medicalBtnTapped(_ sender: UIButton) {
        
        if  let homeViewController = self.storyboard?
              .instantiateViewController(identifier: "VisitHistoryTableAdminVC") as? VisitHistoryTableAdminVC{
      navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
    
    @objc func logout()
    {
        try?  Auth.auth().signOut()
        
        let homeViewController = self.storyboard?
          .instantiateViewController(identifier: K.Storyboard.loginController)
        
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }
}


