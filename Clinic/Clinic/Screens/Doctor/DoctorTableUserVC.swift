//
//  DoctorTableUserVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 19/05/1443 AH.
//


import UIKit
import FirebaseDatabase

class DoctorTableUserVC : UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var ref: DatabaseReference!
  var doctorList = [DoctorModel]()
  var myId = ""
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: "TableViewCellUser",
                             bundle: nil),
                       forCellReuseIdentifier: "TableViewCellUser")
    
    ref = Database.database().reference()
    getDate()
    
  }
  
  
  //Get the doctor information from firebase
  private func getDate() {
    ref.child(K.FireStore.doctorCollection).getData { Error,
      DataShot in
      if Error == nil {
        let data = DataShot.value as? NSDictionary
        
        for (_,v) in data! {
          let value =  v as! NSDictionary
          
          self.doctorList.append(DoctorModel(value: value))
        }
      } else {
        print(Error.debugDescription)
      }
      self.tableView.reloadData()
    }
  }
}


//MARK:- UITableViewDelegate,UITableViewDataSource
extension DoctorTableUserVC : UITableViewDelegate,
                              UITableViewDataSource,
                              MyCellDelegate {
  
  //Transafer next View
  func didPressButton(_ tag: Int) {
    
    print("I have pressed a button with a tag: \(String(describing: self.doctorList[tag].doctorId))")
    
    let _ : UIStoryboard = UIStoryboard(name:"Main",
                                        bundle: nil)
    
    if let addBookUserVC =
        storyboard?.instantiateViewController(identifier:K.Storyboard.addBookUserVC) as? AddBookUserVC {
      
      addBookUserVC.doctorId =
      self.doctorList[tag].doctorId
      addBookUserVC.clinicName =
      self.doctorList[tag].clinicName
      addBookUserVC.doctorName =
      self.doctorList[tag].doctorName
      
      addBookUserVC.modalPresentationStyle = .fullScreen
      
      if !addBookUserVC.time.isEmpty
      {
        addBookUserVC.time = ""
      }
      if addBookUserVC.timeText != nil 
      {
        addBookUserVC.timeText.text?.removeAll()
      }
      navigationController?.pushViewController(addBookUserVC,
                                               animated: true)
    }
  }
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    self.doctorList.count
  }
  
  
  //Show Doctors List(data) in table
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath)
  -> UITableViewCell {
    
    let cell =
    tableView.dequeueReusableCell(withIdentifier: "TableViewCellUser",
                                  
                                  for: indexPath) as? TableViewCellUser
    
    myId = self.doctorList[indexPath.row].doctorName
    
    cell?.bookButton.tag = indexPath.row
    cell?.myCellDelegate = self
    
    if !self.doctorList.isEmpty {
      
      let yearOfExperince = Utilities.calculatorExperince(date: self.doctorList[indexPath.row].hireDate)
      cell?.clinicNameLabel.text =
      self.doctorList[indexPath.row].clinicName
      cell?.doctorNameLabel.text =
      self.doctorList[indexPath.row].doctorName
      
      cell?.yearsOfExperienceLabel.text = String(yearOfExperince)
      
      print("\n\n\nYear Of experince : " + self.doctorList[indexPath.row].hireDate)
    }
    
    cell?.bookButton.layer.cornerRadius = 25.0
    
    return cell!
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
}
