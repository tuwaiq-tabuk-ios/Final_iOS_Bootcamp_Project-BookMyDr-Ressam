//
//  VisitHistoryVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 23/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class VisitHistoryVC: UIViewController {
  
  @IBOutlet weak var patientNameLabel: UILabel!
  @IBOutlet weak var doctorNameLabel: UILabel!
  @IBOutlet weak var ClinicNameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  
  var ref : DatabaseReference!
  var patientList = [PatientModel]()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ref = Database.database().reference()
    getData()
    setUpElements()
  }
  
  
  func setUpElements() {
    patientNameLabel.styleLabel()
    doctorNameLabel.styleLabel()
    ClinicNameLabel.styleLabel()
    dateLabel.styleLabel()
    timeLabel.styleLabel()
  }
  
  
  func getData() {
    ref.child(K.FireStore.patientCollection).queryOrderedByKey()
      .observe(.value) { (snapShot) in
        let snapShotValue = snapShot.value as? NSDictionary
        
        let name = snapShotValue? ["name"] as? String
        let doctorName = snapShotValue?["doctorName"] as? String
        let clinicName = snapShotValue?["clinicName"] as? String
        let date = snapShotValue?["date"] as? String
        let time = snapShotValue?["time"] as? String
        
        self.patientNameLabel.text = name
        self.doctorNameLabel.text = doctorName
        self.ClinicNameLabel.text = clinicName
        self.dateLabel.text = date
        self.timeLabel.text = time
      }
  }
}
