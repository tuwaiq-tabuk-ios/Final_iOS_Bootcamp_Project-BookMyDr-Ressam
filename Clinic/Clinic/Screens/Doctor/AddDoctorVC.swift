//
//  AddDoctorVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 10/05/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseCore
import FirebaseDatabase

class AddDoctorVC: UIViewController ,
                   UIPickerViewDataSource ,
                   UITextFieldDelegate {
  
  @IBOutlet weak var txtSelectDoctor: UITextField!
  @IBOutlet weak var yearsOfExperience: UITextField!
  @IBOutlet weak var doctorNameTextField: UITextField!
  @IBOutlet weak var dismissButton: UIButton!
  
  let pickerSection = UIPickerView()
  
  var ref: DatabaseReference!
  var arrSection = ClinicData().clinicDataList
  var currentIndex = 0
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ref = Database.database().reference()
    
    pickerSection.delegate = self
    pickerSection.dataSource = self
    
    let toolBar = UIToolbar()
    
    toolBar.sizeToFit()
    
    let buttonDone = UIBarButtonItem(title: "Done",
                                     style: .plain,
                                     target: self,
                                     action:#selector(closePicker))
    toolBar.setItems([buttonDone],
                     animated: true)
    
    txtSelectDoctor.inputView = pickerSection
    txtSelectDoctor.inputAccessoryView = toolBar
    setUpElement()
  }
  
  
  func setUpElement() {
    txtSelectDoctor.styleTextField()
    yearsOfExperience.styleTextField()
    doctorNameTextField.styleTextField()
  }
  
  
  //Return to the previous view
  @IBAction func dissmisButtonTapped(_ sender: UIButton) {
    self.dismiss(animated: true,
                 completion: nil)
  }
  
  
  @IBAction func addNewDoctorTapped(_ sender: Any) {
    let DocId = UUID.init().uuidString
    
    let doctor = DoctorModel(doctorId: DocId,
                             doctorName:self.doctorNameTextField.text!,
                             clinicName:arrSection[currentIndex],
                             hireDate:self.yearsOfExperience.text!)
    
    self.ref.child(K.FireStore.doctorCollection).child(doctor.doctorId).setValue(doctor.toDic())
    { [self] error, DataRef in
      if error == nil {
        self.showaAlertDoneView(Title: "Done!",
                                Msg: "Doctor added successfully")
      } else {
        self.showaAlertDoneView(Title: "Error!",
                                Msg: error.debugDescription)
      }
    }
  }
}


// MARK: - UIPickerViewDelegate
extension AddDoctorVC: UIPickerViewDelegate {
  
  
  override func touchesBegan(_ touches: Set<UITouch>,
                             with event: UIEvent?) {
    view.endEditing(true)
  }
  
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  
  func pickerView(_ pickerView: UIPickerView,
                  numberOfRowsInComponent component: Int) -> Int {
    return arrSection.count
  }
  
  
  func pickerView(_ pickerView: UIPickerView,
                  titleForRow row: Int,
                  forComponent component: Int) -> String? {
    return arrSection[row]
  }
  
  
  func pickerView(_ pickerView: UIPickerView,
                  didSelectRow row: Int,
                  inComponent component: Int) {
    //Show the cliln array in cell table
    currentIndex = row
    txtSelectDoctor.text = arrSection[row]
  }
  
  
  @objc func closePicker () {
    txtSelectDoctor.text = arrSection[currentIndex]
    view.endEditing(true)
  }
}
