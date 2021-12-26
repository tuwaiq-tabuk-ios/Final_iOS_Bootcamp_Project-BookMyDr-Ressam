//
//  EditLocationViewController.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 15/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class EditLocationVC: UIViewController {
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var phoneTextField: UITextField!
  @IBOutlet weak var adressTextField: UITextField!
  @IBOutlet weak var errorLabel: UILabel!
  
  var ref : DatabaseReference!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ref = Database.database().reference()
    
  }
  
  
  func validateFields()->String?{
    
    if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        adressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    {
      return "Please fill in all fields."
    }
    return nil
  }
  
  
  @IBAction func dissmisButtonTapped(_ sender: UIButton) {
    
    self.dismiss(animated: true,
                 completion: nil)
  }
  
  
  @IBAction func doneButtonTapped(_ sender: UIButton) {
    
    let error = validateFields()
    if error != nil
    {
      showError(error!)
    }
    else
    {
      let locationId = UUID.init().uuidString
      let location = LocationModel(locationId:locationId,
                                   email:self.emailTextField.text,
                                   phone:self.phoneTextField.text, adress:self.adressTextField.text)
      
      self.ref .child("Location").setValue([
        "locationId" : location.locationId,
        "email": location.email,
        "phone" : location.phone,
        "adress" :location.adress
      ])
      {
        [self] error,
               DataRef in
        if error == nil
        {
          self.showaAlertDoneView(Title: "Done!", Msg: "Changed successfully")
        }
        else
        {
          self.showaAlertDoneView(Title: "Error!", Msg: error.debugDescription)
        }
      }
    }
  }
  
  
  func showError(_ message:String){
    
    errorLabel.text = message
    errorLabel.alpha = 1
  }
}

