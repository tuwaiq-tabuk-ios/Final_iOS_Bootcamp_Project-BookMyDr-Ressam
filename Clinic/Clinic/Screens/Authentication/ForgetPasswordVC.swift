//
//  ForgetPasswordVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 10/06/1443 AH.
//

import UIKit
import Firebase

class ForgetPasswordVC : UIViewController {
  
  @IBOutlet weak var emailTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  @IBAction func forgetPasswordTapped(_ sender: Any) {
    
    let auth = Auth.auth()
    
    auth.sendPasswordReset(withEmail: emailTextField.text!) {
      (error) in
      if let error = error {
        
        self.showaAlertDoneView(Title: "Error",
                                Msg: error.localizedDescription)
        return
      }
      
      self.showaAlertDoneView(Title: "Hurry",
                              Msg: "A password reset email has been sent!")
    }
  }
  
  
  @IBAction func dismissButton(_ sender: UIButton) {
    
    let homeViewController = self.storyboard?
      .instantiateViewController(identifier:K.Storyboard.loginController)
    
    self.view.window?.rootViewController = homeViewController
    self.view.window?.makeKeyAndVisible()
  }
  
  
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
      emailTextField.resignFirstResponder()
  }
}
