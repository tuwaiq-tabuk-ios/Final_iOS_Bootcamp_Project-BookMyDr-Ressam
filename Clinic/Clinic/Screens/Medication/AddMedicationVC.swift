//
//  MedicationVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 23/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class AddMedicationVC: UIViewController {
  
  @IBOutlet weak var patientNameLabel: UILabel!
  @IBOutlet weak var doctorNameLabel: UILabel!
  @IBOutlet weak var departmentNameLabel: UILabel!
  @IBOutlet weak var treatmentTextField: UITextField!
  
  var ref : DatabaseReference!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ref = Database.database().reference()
    setUpElements()
  }
  
  
  func setUpElements() {
    patientNameLabel.styleLabel()
    departmentNameLabel.styleLabel()
    treatmentTextField.styleTextField()
    doctorNameLabel.styleLabel()
  }
  
  
  @IBAction func addButtonTapped(_ sender: UIButton) {
    
    
  }
  
  // Return to the previous view
  @IBAction func backButtonTapped(_ sender: UIButton) {
    self.dismiss(animated: true,
                 completion: nil)
  }
}


