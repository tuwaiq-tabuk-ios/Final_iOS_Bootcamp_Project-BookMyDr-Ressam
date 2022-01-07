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
  
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var tableView2: UITableView!
  @IBOutlet weak var clinicTextField: UITextField!
  @IBOutlet weak var doctorTextField: UITextField!
  @IBOutlet weak var patientNameTextField: UITextField!
  @IBOutlet weak var patientPhoneTextField: UITextField!
  @IBOutlet weak var bookAppointmentButton: UIButton!
  
  var ref : DatabaseReference!
  var pickerView : UIPickerView?
  var listbook = [AppoimentModel]()
  var date : String = ""
  var time : String = ""
  var doctorId : String = ""
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let pickerView = UIPickerView()
    pickerView.delegate = self
    pickerView.dataSource = self
    
    setUpElements()
    
  }
  
  
  func setUpElements() {
    Utilities.stylefilledButton(bookAppointmentButton)
    //    clinicTextField.styleTextField()
    //    doctorTextField.styleTextField()
    //    patientNameTextField.styleTextField()
    //    patientPhoneTextField.styleTextField()
  }
  
  
  @IBAction func bookButtonTapped(_ sender:UIButton) {
    //Validation all text field not empty
    if !clinicTextField.text!.isEmpty &&
        !doctorTextField.text!.isEmpty &&
        !patientNameTextField.text!.isEmpty &&
        !patientPhoneTextField.text!.isEmpty &&
        !date.isEmpty &&
        time.isEmpty {
      
      let patientId = UUID.init().uuidString
      
      let patient = PatientModel(bookId: patientId,
                                 clinicName:self.clinicTextField.text!,
                                 doctorName: self.doctorTextField.text!,
                                 name: self.patientNameTextField.text!,
                                 phone: self.patientPhoneTextField.text!,
                                 date: self.date,
                                 time: self.time,
                                 isAvilable: true)
      
      ref = Database.database().reference().child(K.FireStore.patientCollection).child(doctorId).child(date).child(time).child(patientId)
      
      ref.setValue([
        "patientId":patient.bookId,
        "clinicName": patient.clinicName,
        "doctorName" : patient.doctorName,
        "name":patient.name,
        "Phone":patient.phone,
        "date" : patient.date,
        "time" : patient.time,
        "isAvilable":patient.isAvilable
      ]) { Error,result in
        if Error == nil {
          self.showaAlertDoneView(Title: "Done",
                                  Msg: "Book added Successfully.")
        }
      }
    } else {
      self.showaAlertDoneView(Title: "Error",
                              Msg: "Complete the appointment information")
    }
  }
}


// MARK: - UIPickerViewDelegate
extension BookVC : UIPickerViewDelegate {
  
  
  override func touchesBegan(_ touches: Set<UITouch>,
                             with event: UIEvent?) {
    view.endEditing(true)
  }
  
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 2
  }
  
  
  func pickerView(_ pickerView: UIPickerView,
                  numberOfRowsInComponent component: Int) -> Int {
    return 2
  }
}
