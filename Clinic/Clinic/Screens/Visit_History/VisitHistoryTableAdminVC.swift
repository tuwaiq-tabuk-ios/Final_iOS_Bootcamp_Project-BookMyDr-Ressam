//
//  VisitHistoryTableAdminVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 23/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class VisitHistoryTableAdminVC: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var confirmedBooks = [ConfirmedBooks]()
  var patientConfirmedBooks = [ConfirmedBooks]()
  var patientList = [Patient]()
  var ref: DatabaseReference!
  var myId = ""
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: "VisitHistoryAdminTableViewCell",
                             bundle: nil),
                       forCellReuseIdentifier: "visitCell")
    
    ref = Database.database().reference()
    
    getData()
  }
  
  
  private func getData() {
    
    ref.child(K.RealtimeDatabase.confirmedBooksCollection)
      .getData { Error, dataShot in
        
        if  let data = dataShot.value as? NSDictionary {
          
          for (_,v) in data {
            
            let v1 = v as! NSDictionary
            self.confirmedBooks
              .append(ConfirmedBooks(value: v1))
          }
        } else {
          
          print(Error.debugDescription)
        }
        
        self.tableView.reloadData()
      }
  }
}

//MARK:-UITableViewDelegate,UITableViewDataSource
extension VisitHistoryTableAdminVC : UITableViewDelegate,
                                     UITableViewDataSource {
  
  
  func tableView(_ tableView: UITableView,
                 trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
  -> UISwipeActionsConfiguration? {
    
    let delete = UIContextualAction(style: .destructive,
                                    title: "Delete") { ACTION,
      view,
      result in
      
      self.ref.child(K.RealtimeDatabase.confirmedBooksCollection)
        .child(self.confirmedBooks[indexPath.row].bookId)
        .removeValue()
      result(true)
    }
    
    return UISwipeActionsConfiguration(actions: [delete])
  }
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int)
  -> Int {
    confirmedBooks.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath)
  -> UITableViewCell {
    let cell =
    tableView.dequeueReusableCell(withIdentifier: "visitCell",
                                  for: indexPath) as? VisitHistoryAdminTableViewCell
    var  doctorName =  " "
    
    let doctorId =
    self.confirmedBooks[indexPath.row].doctorId
    
    ref.child(K.RealtimeDatabase.doctorCollection).child(doctorId).getData { error,
      Data in
      
      if let data = Data.value as? NSDictionary {
        
        doctorName =
        data["doctorName"] as? String ?? "No data"
        cell?.doctorLabel.text = doctorName
      }
    }
    
    ref.child(K.RealtimeDatabase.usersCollection)
      .child(self.confirmedBooks[indexPath.row].userId)
      .getData { error, Data in
        
        if let data = Data.value as? NSDictionary {
          let first  =
          data["FirstName"] as? String ?? "No data"
          let last  =
          data["LastName"] as? String ?? "No data"
          
          cell?.patientLabel.text = first + " " + last
        }
      }
    
    cell?.addMedicationButton.tag = indexPath.row
    cell?.myCellDelegate = self
    
    cell?.dateLabel.text =
    self.confirmedBooks[indexPath.row].date
    cell?.timeLabel.text =
    self.confirmedBooks[indexPath.row].time
    
    cell?.accessoryType =
    self.confirmedBooks[indexPath.row]
      .haveMedication ? .checkmark : .none
    
    return cell!
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
}


//MARK: - MyCellDelegate
extension VisitHistoryTableAdminVC : MyCellDelegate {
  
  
  func didPressButton(_ tag: Int) {
    
    let model = self.confirmedBooks[tag]
    _ = UIStoryboard(name: "Main", bundle: nil)
    if let addMedicationVC =
        storyboard?.instantiateViewController(identifier:K.Storyboard.addMedicationVC) as? AddMedicationVC{
      
      addMedicationVC.modalPresentationStyle = .fullScreen
      addMedicationVC.confirmedModel = model
      navigationController?.pushViewController(addMedicationVC,
                                               animated: true)
      
    }
  }
}
