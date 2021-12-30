//
//  SingUpViewController.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 09/05/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseCore
import FirebaseDatabase

class SingUpVC: UIViewController {
  
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var singUpButton: UIButton!
  @IBOutlet weak var errorLabel: UILabel!
  
  var ref: DatabaseReference!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpElements()
    
    ref = Database.database().reference()
  }
  
  
  @IBAction func singUpPressed(_ sender: Any) {
    //    let error = Utilities.validateEmptyFields(textFields: firstNameTextField,
    //                                         lastNameTextField,
    //                                         emailTextField,
    //                                         passwordTextField)
    print("\n\n\n- - - - -  - - - - - - - -\(#file) - \(#function)")
    
    do {
      try Utilities.validateEmptyFields(textFields: firstNameTextField,
                                        lastNameTextField,
                                        emailTextField,
                                        passwordTextField)
    } catch {
      print("ERROR: \(String(describing: CustomError.emptyFields.errorDescription))")
      showError(CustomError.emptyFields.errorDescription ?? "ERROR_NOT_CATCHED: validateEmptyFields(textFields:")
      return
    }
    

    do {
      try passwordTextField.cmValidatePasswordSyntax()
    } catch CustomError.invalidSyntaxPassword {
      
    } catch {
      print("---- ERROR: \(String(describing: CustomError.invalidSyntaxPassword.errorDescription))")
      showError(CustomError.invalidSyntaxPassword.errorDescription ?? "ERROR_NOT_CATCHED: validatePasswordSyntax(passwordTextField:")
      return
    }
    
    let firstName = firstNameTextField.cmTakeOutWhiteSpaces()
    let lastName = lastNameTextField.cmTakeOutWhiteSpaces()
    let email = emailTextField.cmTakeOutWhiteSpaces()
    let password = passwordTextField.cmTakeOutWhiteSpaces()
  
    print(" - email: \(email)")
    print(" - password: \(password)")
    
    Auth.auth().createUser(
      withEmail: email,
      password: password) { (result, errorCreatingUser)  in
      
      if errorCreatingUser != nil {
        self.showError("Error creating user")
      } else {
        let uid = (result?.user.uid)!
        //        let user = UserModel(uid: (result?.user.uid)!,
        //                             firstName: firstName,
        //                             lastName: lastName,
        //                             email: email)
        //
        //        self.ref.child("users").child((result?.user.uid)!).setValue([
        //          "FirstName" : user.firstName!,
        //          "LastName" : user.lastName!,
        //          "Email" : user.email!,
        //          "Id" : user.uid!,
        //          "isAdmin" : false
        //        ])
        
        self.ref.child(K.FireStore.usersCollection).child(uid).setValue([
          "FirstName" : firstName,
          "LastName" : lastName,
          "Email" : email,
          "Id" : uid,
          "isAdmin" : false
        ])
      }
      self.transitionToHome()
    }
  }
  
  
  func setUpElements() {
    errorLabel.isHidden = true
    
    firstNameTextField.styleTextField()
    lastNameTextField.styleTextField()
    emailTextField.styleTextField()
    passwordTextField.styleTextField()
    Utilities.styleHelloButton(singUpButton)
  }
  
  
  func validateFields() -> String? {
    if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        emailTextField.text?.trimmingCharacters(in:.whitespacesAndNewlines) == "" ||
        passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
      return "Please fill in all fields."
    }
    return nil
  }
  
  
  func showError(_ message: String) {
    errorLabel.text = message
    errorLabel.isHidden = false
  }
  
  
  func transitionToHome() {
    let homeViewController
      = storyboard?.instantiateViewController(identifier:K.Storyboard.homeViewController)
    
    view.window?.rootViewController = homeViewController
    view.window?.makeKeyAndVisible()
  }
}
