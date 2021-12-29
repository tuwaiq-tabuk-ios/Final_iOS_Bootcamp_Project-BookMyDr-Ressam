//
//  Utilities.swift
//  WeLearn
//
//  Created by Ressam Al-Thebailah on 04/05/1443 AH.
//

import Foundation
import UIKit

class Utilities {
  
  static func styleTextField (_ textfield : UITextField)
  {
   
    let bottomLine = CALayer()
    
    bottomLine.frame = CGRect(x: 0,
                              y: textfield.frame.height - 2,
                              width: textfield.frame.width,
                              height: 2)
    
    bottomLine.backgroundColor = UIColor.init(red: 100/255,
                                              green: 181/255,
                                              blue: 234/255,
                                              alpha: 1).cgColor
    
    textfield.borderStyle = .none
    
    textfield.layer.addSublayer(bottomLine)
  }
  

  static func stylefilledButton (_ button:UIButton)
  {
    button.backgroundColor = UIColor.init(red: 255/255,
                                          green: 147/255,
                                          blue: 0/255,
                                          alpha: 1)
    button.layer.cornerRadius = 25.0
    button.tintColor = UIColor.white
    button.layer.borderColor = UIColor.white.cgColor
    button.layer.borderWidth = 3
  }
  
  
  static func styleHelloButton (_ button:UIButton)
  {
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.purple.cgColor
    button.layer.cornerRadius = 25.0
    button.tintColor = UIColor.black
  }
  
  
  static func  isPasswordValid(_ password:String)
  ->Bool{
    let passwordTest = NSPredicate(format: "SELF MATCHES%@",
                                   "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
    return passwordTest.evaluate(with: password)
  }
}
