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
//   
//    do {
//      try Auth.auth().signOut()
//      self.dismiss(animated: true, completion: nil)
//    } catch let singOutError {
//      self.present(Serv, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
//    }
  }
  
}
