//
//  MedicationUserVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 23/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class MedicationUserVC: UIViewController {
  
  @IBOutlet weak var patientNameLabel: UILabel!
  @IBOutlet weak var doctorNameLabel: UILabel!
  @IBOutlet weak var departmentNameLabel: UILabel!
  @IBOutlet weak var teartmentNameLabel: UILabel!
  
  var ref : DatabaseReference!
  var confirmedModel = ConfirmedBooks()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ref = Database.database().reference()
    setUpElemnts()
    getData()
  }
  
  
  func setUpElemnts() {
    patientNameLabel.styleLabel()
    doctorNameLabel.styleLabel()
    departmentNameLabel.styleLabel()
    teartmentNameLabel.styleLabel()
  }
  
  
  func getData() {
    
    ref.child(K.RealtimeDatabase.doctorCollection)
      .child(confirmedModel.doctorId).getData { error,Data in
        
        if let data = Data.value as? NSDictionary {
          
          self.doctorNameLabel.text! =
          data["doctorName"] as? String ?? "No data"
          self.departmentNameLabel.text! =
          data["clinicName"] as? String ?? "No data"
        }
      }
    
    self.patientNameLabel.text = confirmedModel.patientName
    
    ref.child(K.RealtimeDatabase.medicationCollection)
      .child(confirmedModel.bookId).getData { error, Data in
        
        if let data = Data.value as? NSDictionary {
          
          self.teartmentNameLabel.text!
          = data["medication"] as? String ?? "No data"
        }
      }
  }
}
