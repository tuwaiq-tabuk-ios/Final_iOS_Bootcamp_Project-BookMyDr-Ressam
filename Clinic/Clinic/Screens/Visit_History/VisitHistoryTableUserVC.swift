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
  var confirmedBooks = [ConfirmedBooksModel]()
  var patientConfirmedBooks = [ConfirmedBooksModel]()
  var patientList = [PatientModel]()
  var ref: DatabaseReference!
  var myId = ""
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: "VisitHistoryTableVC",
                             bundle: nil),
                       forCellReuseIdentifier: "VisitHistoryTableVC")
    
    ref = Database.database().reference()
    
    getData()
  }
  
  
  private func getData() {
    
    ref.child(K.FireStore.confirmedBooksCollection).getData
    { Error,
      dataShot in

      if  let data = dataShot.value as? NSDictionary {
        
        for (_,v) in data {
          
          let v1 = v as! NSDictionary
          self.confirmedBooks.append(ConfirmedBooksModel(value: v1))
        }
      } else {
        
        print(Error.debugDescription)
      }
      for item in self.confirmedBooks
      {
        
        if item.userId == K.FireStore.userId
        {
          
          self.patientConfirmedBooks.append(item)
        }
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
    patientConfirmedBooks.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "VisitHistoryTableVC",
                                             for: indexPath) as? VisitHistoryTableVC
    var  doctorName =  " "
    let doctorId =
      
      self.patientConfirmedBooks[indexPath.row].doctorId
    ref.child("Doctor").child(doctorId).getData { error,
                                                  Data in
      if let data = Data.value as? NSDictionary {
        
        doctorName = data["doctorName"] as? String ?? "No data"
        cell?.doctorLabel.text = doctorName
       }
    }
    
    cell?.medicationButton.tag = indexPath.row
    cell?.dateLabel.text = self.patientConfirmedBooks[indexPath.row].date
    cell?.timeLabel.text = self.patientConfirmedBooks[indexPath.row].time
    cell?.myCellDelegate = self
    
    return cell!
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
}
  

  //MARK:- MyCellDelegate
  extension VisitHistoryTableUserVC : MyCellDelegate {
    
    
    func didPressButton(_ tag: Int) {
      
      let model = self.confirmedBooks[tag]
      let _ : UIStoryboard = UIStoryboard(name:"Main",
                                          bundle: nil)
      
      if let medicationVC =
          storyboard?.instantiateViewController(identifier:K.Storyboard.medicationUserVC) as? MedicationUserVC{
        
        medicationVC.modalPresentationStyle = .fullScreen
        medicationVC.confirmedModel = model
       
        navigationController?.pushViewController(medicationVC, animated: true)
      }
    }
    
    
  }
  
  


