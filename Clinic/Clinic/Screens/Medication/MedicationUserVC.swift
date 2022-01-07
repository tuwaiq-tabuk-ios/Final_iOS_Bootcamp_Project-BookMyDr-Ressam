//
//  MedicationUserVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 23/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class MedicationUserVC: UIViewController {
  
  @IBOutlet weak var patientNameLabel: UILabel!
  @IBOutlet weak var doctorNameLabel: UILabel!
  @IBOutlet weak var departmentNameLabel: UILabel!
  @IBOutlet weak var teartmentNameLabel: UILabel!
  
  var ref : DatabaseReference!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ref = Database.database().reference()
    setUpElemnts()
  }
  
  
  func setUpElemnts() {
    patientNameLabel.styleLabel()
    doctorNameLabel.styleLabel()
    departmentNameLabel.styleLabel()
    teartmentNameLabel.styleLabel()
  }
}
