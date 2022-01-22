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
 static func calculatorExperince(date : String) -> Int
    {
    var year : Int?
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "dd/MM/yyyy"
    if let myDate = dateFormatter.date(from: date) {
      let calendar = Calendar.current
       year = calendar.component(.year, from: Date()) - calendar.component(.year, from: myDate)
    }
    
      return year!
     
    }
  
  static func styleHelloButton (_ button:UIButton) {
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.white.cgColor
    button.layer.cornerRadius = 25.0
    button.tintColor = UIColor.black
  }
  
  
  static func validateEmptyFields(textFields: UITextField...) throws {
    for textField in textFields {
      
      if textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
        throw CustomError.emptyFields
      }
    }
  }
  
}
