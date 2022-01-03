//
//  LoginVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 09/05/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginVC: UIViewController {
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var errorLabel: UILabel!
  
  var ref : DatabaseReference!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ref = Database.database().reference()
    
    setUpElements()
  }
  
  
  @IBAction func loginPressed(_ sender: Any) {
    let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
    Auth.auth().signIn(withEmail: email,
                       password: password) {
      (result,error) in
      
      if let error = error {
        self.errorLabel.text = error.localizedDescription
        self.errorLabel.isHidden = false
      }
      else {
        let userID = Auth.auth().currentUser?.uid
        
        self.ref.child(K.FireStore.usersCollection)
          .queryEqual(toValue: userID).getData { error, Data in
            if error == nil {
              let _ = Data
//              let isData = Data
            }
          }
        
        let homeViewController = self.storyboard?
          .instantiateViewController(identifier: K.Storyboard.homeViewController)
        
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
      }
    }
  }
  
  
  private func setUpElements() {
    errorLabel.alpha = 0
    
    emailTextField.styleTextField()
    passwordTextField.styleTextField()
    Utilities.styleHelloButton(loginButton)
  }
}
