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

  @IBOutlet weak var timeText: UITextField!
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
  var patintName = ""
  var mobile = ""
  var ref : DatabaseReference!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    clinicNameLabel.text = clinicName
    doctorNameLabel.text = doctorName
    tableView.dataSource = self
    tableView.delegate = self
 
    getDates()
    if !Staticv.instance.Time.isEmpty
    {
      timeText.text = Staticv.instance.Time
      self.time = timeText.text!
    }
    
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    print("viewWill Apear Called")
    if !Staticv.instance.Time.isEmpty
    {
      timeText.text = Staticv.instance.Time
    }
  }
  
  @IBAction func bookButtonTapped(_ sender: UIButton)
  {
    let name = patientNameTextField.text!
    let phone = patientPhoneTextField.text!
    print("name is \(name) phone \(phone) date \(self.date) time \(self.timeText.text!)")
    
    if !self.date.isEmpty &&
        !self.timeText.text!.isEmpty &&
        !name.isEmpty &&
        !phone.isEmpty {
      
      let bookId = UUID.init().uuidString
      let book = PatientModel(
        bookId: bookId,
        clinicName: clinicName,
        doctorName: doctorName,
        name:self.patientNameTextField.text!,
        phone:self.patientPhoneTextField.text!,
        date:self.date,
        time:timeText.text!,
        isAvilable:true )
      
      ref = Database.database().reference().child(K.FireStore.patientCollection)
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
      ]) { Error, result in
        if Error == nil {
          self.showaAlertDoneView(Title: "Done",
                                  Msg: "Book added Successfully.")
        }
      }
    } else {
      self.showaAlertDoneView(Title: "Error",
                              Msg: "You must pick date and time.")
    }
  }
}


extension AddBookUserVC :UITableViewDataSource,
                         UITableViewDelegate
{
  
  
  func getDates()
  {
    
    let db : DatabaseReference = Database.database().reference().child(K.FireStore.booksCollection).child(doctorId)
    db.observe(.value) { DataResult in
      if DataResult.value != nil
      {
        for (key,val) in DataResult.value as! NSDictionary
        {
          print("key : \(key)\t\n")
          
          self.dates.append(key as! String)
          self.times.append(key as! String)
          
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
  
  
  func numberOfSections(in tableView: UITableView)
  -> Int {
    return 1
  }
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int)
  -> Int {
    return self.dates.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath)
  {
    self.date = (tableView.cellForRow(at: indexPath)?.textLabel?.text)!
    if !self.times.isEmpty
    {
      self.times.removeAll()
    }
    for item in appoiment
    {
      if item.date == self.date
      {
        self.times.append(item.Time)
        
      }
    }
  
    
    let story = UIStoryboard(name: "Main", bundle: nil)
    let timeController = story.instantiateViewController(identifier: "timeView") as TimeVC
    timeController.modalPresentationStyle = .fullScreen
    timeController.times = self.times
    self.present(timeController, animated: true) {
     print( "sub View Present")
    }
    
   
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath)
  -> UITableViewCell
  {
    let cell = UITableViewCell(style: .default,
                               reuseIdentifier: "myCell")
    let cell2 = UITableViewCell(style: .default,
                                reuseIdentifier: "myCell2")
    
    cell.textLabel!.text = self.dates[indexPath.row]
    cell2.textLabel!.text = self.times[indexPath.row]
    
    return cell
  }
  
  
  
  
}
