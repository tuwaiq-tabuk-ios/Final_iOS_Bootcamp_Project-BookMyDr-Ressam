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
  var iconClick = false
  let imageIcon = UIImageView()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ref = Database.database().reference()
    
    setUpElements()
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
    
    if iconClick
    {
      iconClick = false
      tappedImage.image = UIImage(named: "eye")
      passwordTextField.isSecureTextEntry = false
    } else {
      iconClick = true
      tappedImage.image = UIImage(named: "visibility")
      passwordTextField.isSecureTextEntry = true
    }
  }
  
  @IBAction func loginPressed(_ sender: Any) {
    let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//  try?  Auth.auth().signOut()
    Auth.auth().signIn(withEmail: email,
                       password: password) {
      
      (result,error) in
      
      if let error = error {
        self.errorLabel.text = error.localizedDescription
        self.errorLabel.alpha = 1
        
        
      } else {
      
        K.FireStore.userId = result!.user.uid
        print(K.FireStore.userId)
        self.ref.child(K.FireStore.usersCollection)
          .child(K.FireStore.userId).getData { error, Data in
            if let data = Data.value as? NSDictionary{
              let isAdmin  = data["isAdmin"] as! Bool
              print("isAdmin : \(isAdmin)")
              if isAdmin
              {
                
                let homeViewController = self.storyboard?
                  .instantiateViewController(identifier: K.Storyboard.adminHomeController)
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
                
              }else{
                
                let homeViewController = self.storyboard?
                  .instantiateViewController(identifier: K.Storyboard.userHomeViewController)

                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
              }
            }
          }
      }
    }
  }
  
  
  private func setUpElements() {
    errorLabel.alpha = 0
    
    emailTextField.styleTextField()
    passwordTextField.styleTextField()
    Utilities.styleHelloButton(loginButton)
  }
  
  
  @IBAction func singUpButton(_ sender: Any) {
    
    let homeViewController = self.storyboard?
      .instantiateViewController(identifier:K.Storyboard.singUpController)
    
    self.view.window?.rootViewController = homeViewController
    self.view.window?.makeKeyAndVisible()
    
  }
  
  
  @IBAction func forgetPasswordTapped(_ sender: Any) {
    
    let homeViewController = self.storyboard?
      .instantiateViewController(identifier:K.Storyboard.forgetPasswordVC)
    
    self.view.window?.rootViewController = homeViewController
    self.view.window?.makeKeyAndVisible()
  }
  
  
}
