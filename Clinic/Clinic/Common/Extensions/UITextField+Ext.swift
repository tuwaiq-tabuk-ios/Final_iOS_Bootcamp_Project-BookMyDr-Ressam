//
//  UITextField+Ext.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 25/05/1443 AH.
//

import UIKit

extension UITextField {
  
  
  func styleTextField () {
    let bottomLine = CALayer()
    
    bottomLine.frame = CGRect(x: 0,
                              y: frame.height - 2,
                              width: frame.width,
                              height: 2)
    
    bottomLine.backgroundColor = UIColor.init(red: 255/255,
                                              green: 147/255,
                                              blue: 0/255,
                                              alpha: 1).cgColor
    
    borderStyle = .none
    
    layer.addSublayer(bottomLine)
  }
  
  
  func cmValidatePasswordSyntax() throws {
    let passwordWithoutSpaces = text!
      .trimmingCharacters(in:.whitespacesAndNewlines)
    
    let passwordTest = NSPredicate(format: "SELF MATCHES%@",
                                   "^(?=.*[a-z])(?=.*[$@$#!%*?&_])[A-Za-z\\d$@$#!%*?&_]{8,}")
    
    print("\n\n------------\(#file) - \(#function)")
    if passwordTest.evaluate(with: passwordWithoutSpaces) {
      print("passwordTest Ok: \(passwordTest))")
    } else {
      print("passwordTest NoOk: \(passwordTest))")
      throw CustomError.invalidPassword
    }
  }
  
  
  func cmTakeOutWhiteSpaces() -> String {
    return text!.trimmingCharacters(in: .whitespacesAndNewlines)
  }
}

