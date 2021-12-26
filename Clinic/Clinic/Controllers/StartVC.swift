//
//  ViewController.swift
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
}

