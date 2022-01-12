//
//  AddBookUser.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 19/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class AddBookUserVC: UIViewController,UITextFieldDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var timeText: UITextField!
  @IBOutlet weak var clinicNameText: UITextField!
  @IBOutlet weak var doctorNameText: UITextField!
  @IBOutlet weak var patientNameTextField: UITextField!
  @IBOutlet weak var patientPhoneTextField: UITextField!
  @IBOutlet weak var bookButton: UIButton!
  
  var CliniccurrentIndex = 0 ,  doctorcurrentIndex = 0
  
  var clinicList = ClinicData().clinicDataList
  var Doctors = [DoctorModel]()
  var FilteredDoctors = [DoctorModel]()
  var appoiment = [AppoimentModel]()
  
  var dates = [String]()
  var times = [String]()
  var bookkeys = [String]()
  
  
  let toolBar = UIToolbar()
  
  var doctorId : String = ""
  var clinicName : String = ""
  var doctorName : String = ""
  var date : String = ""
  var time : String = ""
  var key : String = ""
  var patintName = ""
  var mobile = ""
  
  var ref : DatabaseReference!
  
  var picker = UIPickerView()
  
  var doctortapped = false
  var clinicTapped = false
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    getDoctors()
    getDates(id:doctorId)
    setUpElements()
    toolBar.sizeToFit()
    
    
    let buttonDone = UIBarButtonItem(title: "Done",
                                     style: .plain,
                                     target: self,
                                     action:#selector(closePicker) )
    toolBar.setItems([buttonDone],
                     animated: true)
    if !clinicName.isEmpty && !doctorName.isEmpty {
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
    
    clinicNameText.addTarget(self,
                             action:#selector(isTextFieldTapped(Sender:)),
                             
                             for: .allTouchEvents)
    
    doctorNameText.addTarget(self,
                             action:#selector(isTextFieldTapped(Sender:)),
                             for: .allTouchEvents)
    
    if !Staticv.instance.Time.isEmpty {
      timeText.text = Staticv.instance.Time
      self.time = timeText.text!
    }
  }
  
  
  //Get name doctor, clinic name, years of experience from database
  func getDoctors() {
    let db = Database.database().reference().child("Doctor")
    db.getData { Error, Data in
      if Error == nil {
        let data = Data.value as! NSDictionary
        for (_,v) in data {
          let  v1  = v as! NSDictionary
          self.Doctors.append(DoctorModel(value: v1))
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
  
  
  override func viewWillAppear(_ animated: Bool) {
    print("viewWill Apear Called")
    //validation the table view not empty
    if !Staticv.instance.Time.isEmpty
    {
      timeText.text = Staticv.instance.Time
    }
  }
  
  
  @objc func isTextFieldTapped(Sender : UITextField) {
    if Sender.tag == 100 {
      clinicTapped = true
      doctortapped = false
      clinicNameText.inputView = picker
      clinicNameText.inputAccessoryView = toolBar
    } else {
      if !self.FilteredDoctors.isEmpty {
        self.FilteredDoctors.removeAll()
      }
      for item in Doctors {
        if item.clinicName == clinicNameText.text! {
          self.FilteredDoctors.append(item)
        }
      }
      clinicTapped = false
      doctortapped = true
      doctorNameText.inputView = picker
      doctorNameText.inputAccessoryView = toolBar
    }
  }
  
  
  @IBAction func bookButtonTapped(_ sender: UIButton) {
    let name = patientNameTextField.text!
    let phone = patientPhoneTextField.text!
    
    print("name is \(name) phone \(phone) date \(self.date) time \(self.timeText.text!)")
    
    //Validation the Text Field not empty
    if !self.date.isEmpty &&
        !self.timeText.text!.isEmpty &&
        !name.isEmpty &&
        !phone.isEmpty {
      
      //Store the data in firebase
      let bookId = UUID.init().uuidString
      let book = PatientModel(
        bookId: bookId,
        clinicName: self.clinicNameText.text!,
        doctorName: self.doctorNameText.text!,
        name:self.patientNameTextField.text!,
        phone:self.patientPhoneTextField.text!,
        date:self.date,
        time:timeText.text!,
        isAvilable:true)
      
      //Set booking data to firebase
      let confirmedBook = ConfirmedBooksModel(bookId: book.bookId, userId: K.FireStore.userId, doctorId: self.doctorId, date: book.date, time: book.time, haveMedication: false)
      ref = Database.database().reference()
      ref.child(K.FireStore.confirmedBooksCollection).child(book.bookId).setValue(
        confirmedBook.toDic()
      )
      { Error, result in
        if Error == nil {
          //Show this massage without any error
          self.showaAlertDoneView(Title: "Done",
                                  Msg: "Book added Successfully.")
          
          //Check remove the selected time
          let _ = Database.database().reference().child(K.FireStore.availableBooksCollection).child(self.doctorId).child(book.date).child(self.key).removeValue()
          if !self.times.isEmpty {
            self.times.removeAll()
          }
          if !self.appoiment.isEmpty {
            self.appoiment.removeAll()
          }
          if !self.dates.isEmpty {
            self.dates.removeAll()
          }
          
          let story = UIStoryboard(name: "Main",
                                   bundle: nil)
          
          if let next = story.instantiateViewController(identifier: K.Storyboard.userHomeViewController) as? HomeVC {
            next.modalPresentationStyle = .fullScreen
            self.present(next, animated: true, completion: nil)
          }
        }
      }
    } else {
      //Show this massage with error
      self.showaAlertDoneView(Title: "Error",
                              Msg: "You must pick date and time.")
    }
  }
}


//MARK:- UITableViewDataSource,UITableViewDelegate
extension AddBookUserVC :UITableViewDataSource,
                         UITableViewDelegate {
  
  
  func getDates(id : String) {
    //Show all time availble for each doctor
    if !id.isEmpty
    {
      
      let db : DatabaseReference = Database.database().reference()
        .child(K.FireStore.availableBooksCollection).child(id)
      
      db.observe(.value) { DataResult in
        if let data =  DataResult.value , DataResult.exists()  {
          if !self.dates.isEmpty
          {
            self.dates.removeAll()
          }
         
          for (key,val) in data as! NSDictionary {
            
            print("key : \(key)\t\n")
            self.dates.append(key as! String)
            
            for (k,v) in val as! NSDictionary {
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
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return self.dates.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    self.date = (tableView.cellForRow(at: indexPath)?.textLabel?.text)!
    if !self.times.isEmpty {
      self.times.removeAll()
    }
    for item in appoiment {
      if item.date == self.date {
        self.times.append(item.Time)
      }
    }
    self.key  = self.bookkeys[indexPath.row]
    
    let story = UIStoryboard(name: "Main",
                             bundle: nil)
    let timeController = story.instantiateViewController(identifier: "timeView") as TimeVC
    
    timeController.modalPresentationStyle = .fullScreen
    timeController.times = self.times
    self.present(timeController,
                 animated: true)
    {
      print( "sub View Present")
    }
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath)
  -> UITableViewCell {
    let cell = UITableViewCell(style: .default,
                               reuseIdentifier: "myCell")
    
    cell.textLabel!.text = self.dates[indexPath.row]
    
    return cell
  }
}


//MARK:-  UIPickerViewDelegate,UIPickerViewDataSource
extension AddBookUserVC : UIPickerViewDelegate,UIPickerViewDataSource {
  
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  
  func pickerView(_ pickerView: UIPickerView,
                  numberOfRowsInComponent component: Int) -> Int {
    if clinicTapped {
      return clinicList.count
    } else {
      return FilteredDoctors.count
    }
  }
  
  
  func pickerView(_ pickerView: UIPickerView,
                  titleForRow row: Int,
                  forComponent component: Int) -> String? {
    if clinicTapped {
      return clinicList[row]
    } else {
      return self.FilteredDoctors[row].doctorName
    }
  }
  
  //Show department and doctor by picker
  func pickerView(_ pickerView: UIPickerView,
                  didSelectRow row: Int,
                  inComponent component: Int) {
    
    if clinicTapped {
      CliniccurrentIndex = row
      clinicNameText.text = clinicList[row]
      
    } else {
      
      doctorcurrentIndex = row
      doctorNameText.text = FilteredDoctors[row].doctorName
      self.doctorId = FilteredDoctors[row].doctorId
      getDates(id: FilteredDoctors[row].doctorId)
    }
  }
  
  
  @objc func closePicker() {
    view.endEditing(true)
  }
}
