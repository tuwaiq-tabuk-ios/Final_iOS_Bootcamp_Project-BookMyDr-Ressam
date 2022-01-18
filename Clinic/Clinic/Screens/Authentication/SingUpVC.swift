//
//  SingUpVC.swift
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
  
  //MARK:- IBOutlet
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var singUpButton: UIButton!
  @IBOutlet weak var errorLabel: UILabel!
  
  var ref: DatabaseReference!
  var iconClick = false
  let imageIcon = UIImageView()
  
  
  // View Controller lifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpElements()
    
    ref = Database.database().reference()
    
    imageIcon.image = UIImage(named: "visibility")
    
    let contentView = UIView()
    contentView.addSubview(imageIcon)
    
    contentView.frame = CGRect(x: 0,
                               y: 0,
                               width: UIImage(named: "visibility")!.size.width,
                               height: UIImage(named: "visibility")!.size.height)
    
    imageIcon.frame = CGRect(x: -10,
                             y: 0,
                             width: UIImage(named: "visibility")!.size.width,
                             height: UIImage(named: "visibility")!.size.height)
    
    passwordTextField.rightView = contentView
    passwordTextField.rightViewMode = .always
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                      action:#selector(imageTapped(tapGestureRecognizer:)))
    
    imageIcon.isUserInteractionEnabled = true
    imageIcon.addGestureRecognizer(tapGestureRecognizer)
  }
  
  
  @objc func imageTapped(tapGestureRecognizer:UITapGestureRecognizer) {
    
    let tappedImage = tapGestureRecognizer.view as! UIImageView
    
    if iconClick {
      iconClick = false
      tappedImage.image = UIImage(named: "eye")
      passwordTextField.isSecureTextEntry = false
    } else {
      iconClick = true
      tappedImage.image = UIImage(named: "visibility")
      passwordTextField.isSecureTextEntry = true
    }
  }
  
  
  @IBAction func singUpPressed(_ sender: Any) {
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
    }
    catch CustomError.invalidSyntaxPassword {
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
      password: password) { (result,
                             errorCreatingUser)in
      
      if errorCreatingUser != nil {
        
        self.showError("Error creating user")
      } else {
        K.FireStore.userId = (result?.user.uid)!
        
        self.ref.child(K.FireStore.usersCollection).child(K.FireStore.userId).setValue([
          "FirstName" : firstName,
          "LastName" : lastName,
          "Email" : email,
          "Id" : K.FireStore.userId,
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
      = storyboard?.instantiateViewController(identifier:K.Storyboard.userHomeViewController)
    
    view.window?.rootViewController = homeViewController
    view.window?.makeKeyAndVisible()
  }
  
  
  @IBAction func loginButton(_ sender: Any) {
    
    let homeViewController = self.storyboard?
      .instantiateViewController(identifier:K.Storyboard.loginController)
    
    self.view.window?.rootViewController = homeViewController
    self.view.window?.makeKeyAndVisible()
    
    
  }
}
