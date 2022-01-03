//
//  MyMedicalFileVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 23/05/1443 AH.
//

import UIKit

class MyMedicalFileVC : UIViewController {
  
  @IBOutlet weak var visitHistoryButton: UIButton!
  @IBOutlet weak var medicationButton: UIButton!
  
  
  override func viewDidLoad(){
    super.viewDidLoad()
    setUpElements()
  }
  
  
  func setUpElements() {
    Utilities.stylefilledButton(visitHistoryButton)
    Utilities.stylefilledButton(medicationButton)
  }
}
