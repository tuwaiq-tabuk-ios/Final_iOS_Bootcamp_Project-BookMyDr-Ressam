//
//  VisitHistoryVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 23/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class VisitHistoryCV: UIViewController {
  
  @IBOutlet weak var patientNameLabel: UILabel!
  @IBOutlet weak var doctorNameLabel: UILabel!
  @IBOutlet weak var ClinicNameLabel: UILabel!
  @IBOutlet weak var DateLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  
  var ref : DatabaseReference!
  var patientList = [PatientModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ref = Database.database().reference()
    getData()
  }
  
  
  func getData(){
    
    ref.child("Patient").queryOrderedByKey()
      .observe(.value) { (snapShot) in
        let snapShotValue = snapShot.value as? NSDictionary
        
        let name = snapShotValue? ["name"] as? String
        let doctorName = snapShotValue?["doctorName"] as? String
        let clinicName = snapShotValue?["clinicName"] as? String
        
        self.patientNameLabel.text = name
        self.doctorNameLabel.text = doctorName
        self.ClinicNameLabel.text = clinicName

//        self.patientList.append(PatientModel(bookId: <#T##String#>, clinicName: <#T##String#>, doctorName: <#T##String#>, name: <#T##String#>, phone: <#T##String#>, date: <#T##String#>, time: <#T##String#>, isAvilable: <#T##Bool#>))
        
      }
  }
}
