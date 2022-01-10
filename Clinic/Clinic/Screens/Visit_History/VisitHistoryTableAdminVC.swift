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
    tableView.register(UINib(nibName: "visitCell",
                             bundle: nil),
                       forCellReuseIdentifier: "visitCell")
    
    ref = Database.database().reference()
    
    getData()
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
    confirmedBooks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "visitCell",
                                             for: indexPath) as? VisitHistoryAdminTableViewCell
    var  doctorName =  " "
    var  patientName =  " "
    let doctorId = self.confirmedBooks[indexPath.row].doctorId
    ref.child("Doctor").child(doctorId).getData { error, Data in
      if let data = Data.value as? NSDictionary {
        doctorName = data["doctorName"] as? String ?? "No data"
        
        cell?.doctorLabel.text = doctorName
      }
    }
    ref.child(K.FireStore.usersCollection).child(self.confirmedBooks[indexPath.row].userId).getData { error, Data in
      if let data = Data.value as? NSDictionary {
        patientName = data["FirstName"] as? String ?? "No data"
        cell?.patientLabel.text = patientName
      }
    }
    
    
    cell?.dateLabel.text = self.confirmedBooks[indexPath.row].date
    
    return cell!
    
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  
  
  
}
