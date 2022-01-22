//
//  BooKVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 17/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class AddBookVC : UIViewController {
  
  @IBOutlet weak var clinicNameLabel: UILabel!
  @IBOutlet weak var doctorNameLAbel: UILabel!
  @IBOutlet weak var dateAvailable: UIDatePicker!
  @IBOutlet weak var bookAppointment: UIButton!
  
  let pickerSection = UIPickerView()
  let picker = UIDatePicker()
  
  var ref : DatabaseReference!
  var doctorId : String = ""
  var clinicName : String = ""
  var doctorName : String = ""
  var date : String = ""
  var time : String = ""
  
  
  //Add date and time
  @IBAction func DateChanged(_ sender: UIDatePicker) {
    let getdate = sender.date
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "dd-MM-yyyy"
    self.date = dateFormatter.string(from: getdate)
    print(self.date)
    
    let components = Calendar.current.dateComponents([.hour,.minute],
                                                     from: getdate)
    var hour = components.hour!
    var kind = " A.M"
    let minute = components.minute!
    if hour > 12
    {
      hour = hour - 12
      kind = " P.M"
    }
    self.time = String (hour) + " : " + String(minute) + kind
    
    print(self.time)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print(doctorId)
    
    clinicNameLabel.text = clinicName
    doctorNameLAbel.text = doctorName
    
    setUpElements()
    
  }
  
  
  func setUpElements() {
    Utilities.stylefilledButton(bookAppointment)
    clinicNameLabel.styleLabel()
    doctorNameLAbel.styleLabel()
  }
  
  
  @IBAction func addBook(_ sender: UIButton) {
    //Validation date and time not empty
    if  !date.isEmpty && !time.isEmpty {
      
      let book = AppoimentModel(clinicName: clinicName,
                                doctorName: doctorName,
                                date: self.date,
                                Time: self.time,
                                isAvilable: true)
      
      let uid = UUID.init().uuidString
      //Store date and time in Firebase
      ref = Database.database().reference().child(K.FireStore.availableBooksCollection)
        .child(doctorId).child(date).child(uid)
      ref.setValue([
        "clinicName":book.clinicName,
        "doctorName":book.doctorName,
        "date":book.date,
        "time":book.Time,
        "isAvilable":book.isAvilable
      ])
      {
        Error, result in
        if Error == nil {
          //Show this massage without ane error
          self.showaAlertDoneView(Title: "Done",
                                  Msg: "Book added Successfully.")
        }
      }
    } else {
      //Show this massage with error
      self.showaAlertDoneView(Title: "Error",
                              Msg: "You must pick date and time.")
    }
  }
}





