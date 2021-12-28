//
//  BookVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 18/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class BookVC : UIViewController,
               UIPickerViewDataSource,
               UITextFieldDelegate {

 
  @IBOutlet weak var clinicTextField: UITextField!
  @IBOutlet weak var doctorTextField: UITextField!
  @IBOutlet weak var patientName: UITextField!
  @IBOutlet weak var patientPhone: UITextField!
  @IBOutlet weak var bookAppointmentButton: UIButton!
  
  var ref : DatabaseReference!
  var pickerView : UIPickerView?
  var listbook = [AppoimentModel]()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let pickerView = UIPickerView()
    pickerView.delegate = self
    pickerView.dataSource = self
    
  }
  
  
  func getData()
  {
    ref = Database.database().reference().child("Doctor")
  }
}


// MARK: - UIPickerViewDelegate

extension BookVC : UIPickerViewDelegate {
  
  override func touchesBegan(_ touches: Set<UITouch>,
                             with event: UIEvent?)
  {
    view.endEditing(true)
  }
  
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 2
  }


  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return 2
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
