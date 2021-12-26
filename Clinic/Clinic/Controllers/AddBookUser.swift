//
//  AddBookUser.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 19/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class AddBookUser: UIViewController {
  
  @IBOutlet weak var clinicNameLabel: UILabel!
  @IBOutlet weak var doctorNameLabel: UILabel!
  @IBOutlet weak var patientNameTextField: UITextField!
  @IBOutlet weak var patientPhoneTextField: UITextField!
  @IBOutlet weak var bookButton: UIButton!
  
  var doctorId : String = ""
  var clinicName : String = ""
  var doctorName : String = ""
  var date : String = ""
  var time : String = ""
  var ref : DatabaseReference!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    clinicNameLabel.text = clinicName
    doctorNameLabel.text = doctorName
  }
  
  
  @IBAction func bookButtonTapped(_ sender: UIButton) {
    
    if  !date.isEmpty &&
          !time.isEmpty &&
          !patientNameTextField.text!.isEmpty &&
          !patientPhoneTextField.text!.isEmpty
    {
      let bookId = UUID.init().uuidString
      let book = PatientModel(bookId: bookId,
                              clinicName: clinicName,
                              doctorName: doctorName, name:self.patientNameTextField.text!,
                              phone: self.patientPhoneTextField.text!,
                              date: self.date,
                              time: self.date,
                              isAvilable:true)
      
      ref = Database.database().reference().child("Books")
        .child(doctorId).child(date).child(bookId)
      ref.setValue([
        "bookId": book.bookId,
        "clinicName" :book.clinicName,
        "doctorName" : book.doctorName,
        "name" :book.name,
        "Phone":book.phone,
        "date" : book.date,
        "time" : book.time,
        "isAvilable":book.isAvilable
      ])
      {
        Error, result in
        if Error == nil
        {
          self.showaAlertDoneView(Title: "Done",
                                  Msg: "Book added Successfully.")
        }
      }
    }
    else
    {
      self.showaAlertDoneView(Title: "Error",
                              Msg: "You must pick date and time.")
    }
  }
}
