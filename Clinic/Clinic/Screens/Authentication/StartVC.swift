//
//  StartVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 09/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var singUpButton: UIButton!
  @IBOutlet weak var loginButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpElements()
  }
  
  
  func setUpElements() {
    Utilities.stylefilledButton(singUpButton)
    Utilities.stylefilledButton(loginButton)
  }
  
  
  @IBAction func singUpButton(_ sender: Any) {
    
    let homeViewController = self.storyboard?
      .instantiateViewController(identifier:K.Storyboard.singUpController)
    
    self.view.window?.rootViewController = homeViewController
    self.view.window?.makeKeyAndVisible()
  }
  
  
  @IBAction func loginButton(_ sender: Any) {
    
    let homeViewController = self.storyboard?
      .instantiateViewController(identifier:K.Storyboard.loginController)
    
    self.view.window?.rootViewController = homeViewController
    self.view.window?.makeKeyAndVisible()
    
  }
}


