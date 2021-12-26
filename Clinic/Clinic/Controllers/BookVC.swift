//
//  BookVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 18/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class BookVC : UIViewController {
 
  @IBOutlet weak var clinicTextField: UITextField!
  @IBOutlet weak var doctorTextField: UITextField!
  @IBOutlet weak var patientName: UIStackView!
  @IBOutlet weak var patientPhone: UITextField!
  
  var ref : DatabaseReference!
 
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ref = Database.database().reference()
  }
  
}


// MARK: - UIPickerViewDelegate

extension BookVC : UIPickerViewDelegate {
  
  
  override func touchesBegan(_ touches: Set<UITouch>,
                             with event: UIEvent?) {
    
    view.endEditing(true)
  }
  
  
//  func numberOfComponents(in pickerView: UIPickerView) -> Int {
//    <#code#>
//  }
//
//
//  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//    <#code#>
//  }
//
//
//  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//    <#code#>
//  }
}
