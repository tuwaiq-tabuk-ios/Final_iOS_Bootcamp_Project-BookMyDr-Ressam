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
    
    print("Uid \(K.RealtimeDatabase.userId)")
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "power.circle.fill"),
                                                        style: .plain, target: self,
                                                        action: #selector(logout))
  }
  
  
  @IBAction func btnLocationTapped(_ sender: UIButton) {
    
    if  let homeViewController = self.storyboard?
          .instantiateViewController(identifier:K.Storyboard.locationClinicUserVC) as? LocationClinicUserVC {
      
      navigationController?.pushViewController(homeViewController,
                                               animated: true)
    }
  }
  
  
  @IBAction func BtnAppointmentTapped(_ sender: UIButton) {
    
    if  let homeViewController = self.storyboard?
          .instantiateViewController(identifier: "AddBookUser") as? AddBookUserVC{
      
      navigationController?.pushViewController(homeViewController,
                                               animated: true)
    }
  }
  
  
  @IBAction func btnMedicalTapped(_ sender: UIButton) {
    
    if  let homeViewController = self.storyboard?
          .instantiateViewController(identifier: K.Storyboard.visitHistoryTableUserVC) as? VisitHistoryTableUserVC {
      navigationController?.pushViewController(homeViewController,
                                               animated: true)
    }
  }
  
  
  @IBAction func btnDoctorTapped(_ sender: UIButton) {
    
    if  let homeViewController = self.storyboard?
          .instantiateViewController(identifier:K.Storyboard.doctorTableUserVC) as? DoctorTableUserVC {
      navigationController?.pushViewController(homeViewController,
                                               animated: true)
    }
  }
  
  
  @objc func logout() {
    try?  Auth.auth().signOut()
    
    let homeViewController = self.storyboard?
      .instantiateViewController(identifier: K.Storyboard.loginController)
    
    self.view.window?.rootViewController = homeViewController
    self.view.window?.makeKeyAndVisible()
  }
  
}

