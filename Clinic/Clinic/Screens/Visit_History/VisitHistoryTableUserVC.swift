//
//  VisitHistoryTableUserVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 01/06/1443 AH.
//

import UIKit
import FirebaseDatabase

class VisitHistoryTableUserVC : UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var patientList = [PatientModel]()
  var ref: DatabaseReference!
  var myId = ""
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: "VisitHistoryTableVC", bundle: nil), forCellReuseIdentifier: "VisitHistoryTableVC")
    
    ref = Database.database().reference()
    
    getData()
  }
  
  
  private func getData(){
    ref.child(K.FireStore.patientCollection).child(K.FireStore.userId).getData
    { Error, dataShot in
      if Error == nil {
        
        let data = dataShot.value as? NSDictionary
        
        var bookId = ""
        var DoctorName = ""
        var ClinicName = ""
        var name = ""
        var phone = ""
        var date = ""
        var time = ""
        
        for (_,v) in data! {
          let v1 = v as! NSDictionary
          for (_,v2) in v1
          {
            let v3  = v2 as! NSDictionary
            print(v3.allKeys)
            bookId = v3["bookId"] as? String ?? " "
            DoctorName = v3["doctorName"] as? String ?? " "
            ClinicName = v3["clinicName"] as? String ?? " "
            name = v3["name"] as? String ?? " "
            phone = v3["Phone"] as? String ?? " "
            date = v3["date"] as? String ?? " "
            time = v3["time"] as? String ?? " "
            self.patientList.append(PatientModel(bookId:bookId , clinicName: ClinicName, doctorName: DoctorName, name: name, phone:phone , date: date, time: time, isAvilable: true))
          }
        }
    } else {
      print(Error.debugDescription)
    }
    self.tableView.reloadData()
  }
}
}


//MARK:- UITableViewDelegate,UITableViewDataSource
extension VisitHistoryTableUserVC : UITableViewDelegate,UITableViewDataSource
//                                    , MyCellDelegate
{
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    patientList.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "VisitHistoryTableVC",
                                             for: indexPath) as? VisitHistoryTableVC
    //    myId = self.patientList[indexPath.row].doctorName
    
    //    if !self.patientList.isEmpty {
    cell?.doctorLabel.text = self.patientList[indexPath.row].doctorName
    
    cell?.dateLabel.text = self.patientList[indexPath.row].date
    //
    //    }
    return cell!
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  
  
  //  func didPressButton(_ tag: Int) {
  //    print("I have pressed a button with a tag: \(String(describing: self.patientList[tag].bookId))")
  //
  //    let storyBoard : UIStoryboard = UIStoryboard(name:"Main",
  //                                                 bundle: nil)
  //    let _ : UIStoryboard = UIStoryboard(name:"Main",
  //                                                 bundle: nil)
  //
  //    if let visitHistoryVC =
  //        storyboard?.instantiateViewController(identifier:"VisitHistoryCV") as? VisitHistoryCV{
  //      visitHistoryVC.ClinicNameLabel = patientList[tag].clinicName
  //      addBookUserVC.clinicName = self.doctorList[tag].ClinicName
  //      addBookUserVC.doctorName = self.doctorList[tag].DoctorName
  //      addBookUserVC.modalPresentationStyle = .fullScreen
  //
  //      self.present(addBookUserVC,
  //                   animated: true,
  //                   completion: nil)
  //    }
  //  }
  
  
  
}

