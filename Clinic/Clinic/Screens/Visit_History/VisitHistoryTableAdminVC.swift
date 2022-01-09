//
//  VisitHistoryVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 23/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class VisitHistoryTableAdminVC: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var confirmedBooks = [ConfirmedBooksModel]()
  var patientConfirmedBooks = [ConfirmedBooksModel]()
  var patientList = [PatientModel]()
  var ref: DatabaseReference!
  var myId = ""
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: "myCell",
                             bundle: nil),
                       forCellReuseIdentifier: "myCell")
    
    ref = Database.database().reference()
    
    
  }
  
  
  private func getData() {
    ref.child(K.FireStore.confirmedBooksCollection).getData
    { Error, dataShot in

      if  let data = dataShot.value as? NSDictionary {
        for (_,v) in data {
          let v1 = v as! NSDictionary
          self.confirmedBooks.append(ConfirmedBooksModel(value: v1))
        }
      } else {
        print(Error.debugDescription)
      }
      self.tableView.reloadData()
    }}
}

extension VisitHistoryTableAdminVC : UITableViewDelegate,UITableViewDataSource{
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    patientConfirmedBooks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "myCell",
                                             for: indexPath) as? VisitHistoryAdminTableViewCell
    var  doctorName =  " "
    var  patientName =  " "
    let doctorId = self.patientConfirmedBooks[indexPath.row].doctorId
    ref.child("Doctor").child(doctorId).getData { error, Data in
      if let data = Data.value as? NSDictionary {
        doctorName = data["doctorName"] as? String ?? "No data"
        patientName = data["FirstName"] as? String ?? "No data"
        cell?.doctorLabel.text = doctorName
        cell?.patientLabel.text = patientName
       }
    }
    
    cell?.dateLabel.text = self.patientConfirmedBooks[indexPath.row].date
    
    return cell!
  
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  
  
  
}
