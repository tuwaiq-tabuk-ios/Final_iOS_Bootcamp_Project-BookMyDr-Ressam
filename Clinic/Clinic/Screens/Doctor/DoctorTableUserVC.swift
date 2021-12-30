//
//  DoctorTableUser.swift
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
  
  
  private func getDate() {
    ref.child(K.FireStore.doctorCollection).getData { Error,
                                  DataShot in
      if Error == nil {
        let data = DataShot.value as? NSDictionary
        var DoctorId = ""
        var DoctorName = ""
        var ClinicName = ""
        var YearsOfExperince = ""
        
        for (_,v) in data!{
          for (key,val) in v as! NSDictionary {
            if key as! String == "DoctorId" {
              DoctorId = val as! String
            } else if key as! String == "DoctorName" {
              DoctorName = val as! String
            } else if key as! String == "ClinicName" {
              ClinicName = val as! String
            } else if key as! String == "YearsOfExperience" {
              YearsOfExperince = val as! String
            }
          }
          self.doctorList.append(DoctorModel(DoctorId: DoctorId,
                                             DoctorName: DoctorName,
                                             ClinicName: ClinicName,
                                             YearsOfExperience: YearsOfExperince))
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
  
  
  func didPressButton(_ tag: Int) {
    print("I have pressed a button with a tag:\(self.doctorList[tag].DoctorId)")
    
    let storyBoard : UIStoryboard = UIStoryboard(name:"Main",
                                                 bundle: nil)
    
    if let addBookUserVC =
        storyboard?.instantiateViewController(identifier:K.Storyboard.addBookUserVC) as? AddBookUserVC{
      addBookUserVC.doctorId = self.doctorList[tag].DoctorId
      addBookUserVC.clinicName = self.doctorList[tag].ClinicName
      addBookUserVC.doctorName = self.doctorList[tag].DoctorName
      addBookUserVC.modalPresentationStyle = .fullScreen
      
      self.present(addBookUserVC,
                   animated: true,
                   completion: nil)
    }
  }
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    self.doctorList.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellUser",
                                             for: indexPath) as? TableViewCellUser
    
    myId = self.doctorList[indexPath.row].DoctorName
    
    cell?.bookButton.tag = indexPath.row
    cell?.myCellDelegate = self
    
    if !self.doctorList.isEmpty {
      cell?.clinicNameLabel.text = self.doctorList[indexPath.row].ClinicName
      cell?.doctorNameLabel.text = self.doctorList[indexPath.row].DoctorName
      cell?.yearsOfExperienceLabel.text = self.doctorList[indexPath.row].YearsOfExperience
      print("\n\n\nYear Of experince : " + self.doctorList[indexPath.row].YearsOfExperience)
    }
    return cell!
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
}
