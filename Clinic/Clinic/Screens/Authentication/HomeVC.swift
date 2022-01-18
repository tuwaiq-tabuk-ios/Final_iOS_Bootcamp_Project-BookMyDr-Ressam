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
    @IBAction func btnLocationTapped(_ sender: UIButton) {
        if  let homeViewController = self.storyboard?
              .instantiateViewController(identifier: "LocationClinicUserVC") as? LocationClinicUserVC{
      navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
    
    @IBAction func BtnAppointmentTapped(_ sender: UIButton) {
        
        if  let homeViewController = self.storyboard?
              .instantiateViewController(identifier: "AddBookUser") as? AddBookUserVC{
      navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
    
    @IBAction func btnMedicalTapped(_ sender: UIButton) {
        if  let homeViewController = self.storyboard?
              .instantiateViewController(identifier: "VisitHistoryTableUserVC") as? VisitHistoryTableUserVC{
      navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
    @IBAction func btnDoctorTapped(_ sender: UIButton) {
        if  let homeViewController = self.storyboard?
              .instantiateViewController(identifier: "DoctorTableUserVC") as? DoctorTableUserVC{
      navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
    @IBAction func logOutButtonTapped(_ sender: Any) {
    try?  Auth.auth().signOut()
    
    let homeViewController = self.storyboard?
      .instantiateViewController(identifier: K.Storyboard.loginController)
    
    self.view.window?.rootViewController = homeViewController
    self.view.window?.makeKeyAndVisible()
  }
  
}
