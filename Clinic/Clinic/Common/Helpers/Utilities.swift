//
//  Utilities.swift
//  WeLearn
//
//  Created by Ressam Al-Thebailah on 04/05/1443 AH.
//

import UIKit

class Utilities {
  
  static func stylefilledButton (_ button:UIButton) {
    button.backgroundColor = UIColor.init(red: 255/255,
                                          green: 147/255,
                                          blue: 0/255,
                                          alpha: 1)
    button.layer.cornerRadius = 25.0
    button.tintColor = UIColor.white
    button.layer.borderColor = UIColor.white.cgColor
    button.layer.borderWidth = 3
  }
  
  
  static func styleHelloButton (_ button:UIButton) {
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.purple.cgColor
    button.layer.cornerRadius = 25.0
    button.tintColor = UIColor.black
  }
  
  
//  static func isPasswordValid(_ password: String) -> Bool {
//    let passwordTest = NSPredicate(format: "SELF MATCHES%@",
//                                   "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
//    return passwordTest.evaluate(with: password)
//  }
  
  
  static func validateEmptyFields(textFields: UITextField...) throws {
    
    for textField in textFields {
      if textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
        throw CustomError.emptyFields
      }
    }
  }
  
}
