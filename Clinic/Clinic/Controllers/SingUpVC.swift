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
  @IBOutlet weak var lasttNameTextField: UITextField!
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
  
  
  func setUpElements()
  {
    errorLabel.alpha = 0
    
    Utilities.styleTextField(firstNameTextField)
    Utilities.styleTextField(lasttNameTextField)
    Utilities.styleTextField(emailTextField)
    Utilities.styleTextField(passwordTextField)
    Utilities.styleHelloButton(singUpButton)
  }
  
  
  func validateFields()->String?
  {
    if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        lasttNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        emailTextField.text?.trimmingCharacters(in:.whitespacesAndNewlines) == "" ||
        passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    {
      return "Please fill in all fields."
    }
    
    let cleanedPassword = passwordTextField.text!
      .trimmingCharacters(in:.whitespacesAndNewlines)
    
    if  Utilities.isPasswordValid(cleanedPassword) ==
          false
    {
      return"Please make sure your password is at least 8 characters, contains a special charactar and a number. "
    }
    return nil
  }
  
  
  @IBAction func singUpTappped(_ sender: Any)
  {
    let error = validateFields()
    
    if error != nil{
      showError(error!)
    } 
    else
    {
      let firstName = firstNameTextField.text!
        .trimmingCharacters(in: .whitespacesAndNewlines)
      let lastName = lasttNameTextField.text!
        .trimmingCharacters(in: .whitespacesAndNewlines)
      let email = emailTextField.text!
        .trimmingCharacters(in: .whitespacesAndNewlines)
      let password = passwordTextField.text!
        .trimmingCharacters(in: .whitespacesAndNewlines)
      
      Auth.auth().createUser(withEmail: email,
                             password: password)
      {
        (result,
         err)  in
        
        if err != nil {
          
          self.showError("Error creating user")
        }
        else
        {
          let user = UserModel(uid: (result?.user.uid)!,
                               firstName: self.firstNameTextField.text!,
                               lastName: self.lasttNameTextField.text!,
                               email: self.emailTextField.text!)
          
          self.ref.child("users").child((result?.user.uid)!).setValue([
            "FirstName" : user.firstName!,
            "LastName" : user.lastName!,
            "Email" : user.email!,
            "Id" : user.uid!,
            "isAdmin" : false
          ])
          
          if error != nil{
            self.showError("Error saving user data")
          }
        }
        self.transitionToHome()
      }
    }
  }
  
  
  func showError(_ message:String)
  {
    errorLabel.text = message
    errorLabel.alpha = 1
  }
  
  
  func transitionToHome()
  {
    let homeViewController = storyboard?.instantiateViewController(identifier:"HomeVC")
    
    view.window?.rootViewController = homeViewController
    view.window?.makeKeyAndVisible()
    
  }
}
