//
//  AddBookUser.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 19/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class AddBookUserVC: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate {
  
  var CliniccurrentIndex = 0 ,  doctorcurrentIndex = 0
  var clinicList = ClinicData().clinicDataList
  var Doctors = [DoctorModel]()
  var FilteredDoctors = [DoctorModel]()
  var appoiment = [AppoimentModel]()
  var dates = [String]()
  var times = [String]()
  var bookkeys = [String]()
  var key : String = ""
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var timeText: UITextField!
  @IBOutlet weak var clinicNameText: UITextField!
  @IBOutlet weak var doctorNameText: UITextField!
  @IBOutlet weak var patientNameTextField: UITextField!
  @IBOutlet weak var patientPhoneTextField: UITextField!
  @IBOutlet weak var bookButton: UIButton!
  let toolBar = UIToolbar()
  var doctorId : String = ""
  var clinicName : String = ""
  var doctorName : String = ""
  var date : String = ""
  var time : String = ""
  var patintName = ""
  var mobile = ""
  var ref : DatabaseReference!
  var picker = UIPickerView()
  var doctortapped = false
  var clinicTapped = false
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getDoctors()
    toolBar.sizeToFit()
    
    
    let buttonDone = UIBarButtonItem(title: "Done",
                                     style: .plain,
                                     target: self,
                                     action:#selector(closePicker) )
    toolBar.setItems([buttonDone],
                     animated: true)
    if !clinicName.isEmpty && !doctorName.isEmpty
    {
      clinicNameText.text = clinicName
      doctorNameText.text = doctorName
      self.clinicNameText.isEnabled = false
      self.doctorNameText.isEnabled = false
    }
    
    picker.dataSource = self
    picker.delegate = self
    clinicNameText.delegate = self
    doctorNameText.delegate = self
    tableView.dataSource = self
    tableView.delegate = self
    clinicNameText.tag = 100
    doctorNameText.tag = 200
    clinicNameText.addTarget(self, action:#selector(isTextFieldTapped(Sender:)), for: .allTouchEvents)
    doctorNameText.addTarget(self, action:#selector(isTextFieldTapped(Sender:)), for: .allTouchEvents)
    
    getDates()
    if !Staticv.instance.Time.isEmpty
    {
      timeText.text = Staticv.instance.Time
      self.time = timeText.text!
    }
    
    setUpElements()
  }
  
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
    if clinicTapped
    {
      return clinicList.count
    }else
    {
      return FilteredDoctors.count
    }
    
  }
  
  
  func pickerView(_ pickerView: UIPickerView,
                  titleForRow row: Int,
                  forComponent component: Int) -> String? {
    if clinicTapped {
      return clinicList[row]
    }else
    {
      
      return self.FilteredDoctors[row].DoctorName
    }
  }
  
  
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
      if clinicTapped
      {
        CliniccurrentIndex = row
        clinicNameText.text = clinicList[row]
      }else
      {
        doctorcurrentIndex = row
        doctorNameText.text = FilteredDoctors[row].DoctorName
      }
     
    }
  
  
  func getDoctors()
  {
    let db = Database.database().reference().child("Doctor")
    db.getData { Error, Data in
      if Error == nil
      {
        let data = Data.value as! NSDictionary
        for (_,v) in data {
         let  v1  = v as! NSDictionary
          self.Doctors.append(DoctorModel(DoctorId: (v1["DoctorId"] as! String),
                                          DoctorName:  (v1["DoctorName"] as! String),
                                          ClinicName: (v1["ClinicName"] as! String), YearsOfExperience: (v1["YearsOfExperience"] as! String)))
        }
      }
    }
  }
  
  
  func setUpElements() {
    Utilities.stylefilledButton(bookButton)
    
    clinicNameText.styleTextField()
    doctorNameText.styleTextField()
    
    patientNameTextField.styleTextField()
    patientPhoneTextField.styleTextField()
    timeText.styleTextField()
  }
  
  
  @objc func closePicker() {
//    if tag == 100
//    {
//      clinicNameText.text = clinicList[CliniccurrentIndex]
//    }else
//    {
//      doctorNameText.text = clinicList[doctorcurrentIndex]
//    }
    //  txtSelectDoctor.text = arrSection[currentIndex]
    view.endEditing(true)
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    print("viewWill Apear Called")
    //validation the table view not empty
    if !Staticv.instance.Time.isEmpty
    {
      timeText.text = Staticv.instance.Time
    }
  }
  
  
  @objc func isTextFieldTapped(Sender : UITextField)
  {
    
    if Sender.tag == 100
    {
     
      clinicTapped = true
      doctortapped = false
      clinicNameText.inputView = picker
      clinicNameText.inputAccessoryView = toolBar
    }else
    {
      if !self.FilteredDoctors.isEmpty
      {
        self.FilteredDoctors.removeAll()
      }
      for item in Doctors {
        if item.ClinicName == clinicNameText.text! {
          self.FilteredDoctors.append(item)
        }
      }
      clinicTapped = false
      doctortapped = true
      doctorNameText.inputView = picker
      doctorNameText.inputAccessoryView = toolBar
    }
   
  }
  
  
  @IBAction func bookButtonTapped(_ sender: UIButton)
  {
    let name = patientNameTextField.text!
    let phone = patientPhoneTextField.text!
    print("name is \(name) phone \(phone) date \(self.date) time \(self.timeText.text!)")
    //validation the Text Field not empty
    if !self.date.isEmpty &&
        !self.timeText.text!.isEmpty &&
        !name.isEmpty &&
        !phone.isEmpty {
      // store the data in firebase
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
          
          let _ = Database.database().reference().child(K.FireStore.booksCollection).child(self.doctorId).child(book.date).child(self.key).removeValue()
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
    if !doctorId.isEmpty
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
            
            for (k,v) in val as! NSDictionary
            {
              self.bookkeys.append(k as! String)
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
    
    self.key  = self.bookkeys[indexPath.row]
    
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
    //    let cell2 = UITableViewCell(style: .default,
    //                                reuseIdentifier: "myCell2")
    
    cell.textLabel!.text = self.dates[indexPath.row]
    //    cell2.textLabel!.text = self.times[indexPath.row]
    
    return cell
  }
  
  
  
  
}
