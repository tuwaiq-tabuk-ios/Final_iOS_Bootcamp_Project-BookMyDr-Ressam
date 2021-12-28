//
//  AddBookUser.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 19/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class AddBookUserVC: UIViewController {
 
  var appoiment = [AppoimentModel]()
  var dates = [String]()
  var times = [String]()
  
  @IBOutlet weak var tableView: UITableView!
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
    tableView.dataSource = self
    tableView.delegate = self
    getDates()
  }
  
  
  @IBAction func bookButtonTapped(_ sender: UIButton)
  {
    if  !date.isEmpty &&
          !time.isEmpty &&
          !patientNameTextField.text!.isEmpty &&
          !patientPhoneTextField.text!.isEmpty
    {
      let bookId = UUID.init().uuidString
      let book = PatientModel(
        bookId: bookId,
                              clinicName: clinicName,
                              doctorName: doctorName,
                              name:self.patientNameTextField.text!,
                              phone: self.patientPhoneTextField.text!,
                              date: self.date,
                              time: self.date,
                              isAvilable:true)
      
      ref = Database.database().reference().child("Patient")
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


extension AddBookUserVC :UITableViewDataSource,UITableViewDelegate
{
 
  func getDates()
  {
   
    let db : DatabaseReference = Database.database().reference().child("Books").child(doctorId)
    db.observe(.value) { DataResult in
      if DataResult.value != nil
      {
        
        for (key,val) in DataResult.value as! NSDictionary
        {
          print("key : \(key)\t\n")
        
          self.dates.append(key as! String)

          for (_ ,v) in val as! NSDictionary
          {
            let V = v as! NSDictionary
            
            self.appoiment.append(AppoimentModel(
              clinicName: V["clinicName"] as! String,
              doctorName: V["doctorName"] as! String,
              date: V["date"] as! String,
              Time: V["time"] as! String,
              isAvilable: V["isAvilable"] as! Bool))
          }
        }
        self.tableView.reloadData()
      }
    }
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.dates.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath)
  {
    var myDate = tableView.cellForRow(at: indexPath)?.textLabel?.text
    if !self.times.isEmpty
    {
      self.times.removeAll()
    }
    for item in appoiment {
      if item.date == myDate {
        self.times.append(item.Time)
        
      }
    }
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = UITableViewCell(style: .default, reuseIdentifier: "myCell")
    
    cell.textLabel!.text = self.dates[indexPath.row]
    return cell
  }
}
