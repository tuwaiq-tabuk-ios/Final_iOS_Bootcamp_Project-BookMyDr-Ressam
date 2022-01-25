//
//  MedicationModel.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 05/06/1443 AH.
//

import Foundation

struct Medication {
  var bookId :String
  var medication :String
  
  init(value:NSDictionary)
  {
    self.bookId = value["bookId"] as! String
    self.medication = value["medication"] as! String
  }
  
  init(bookId : String ,
       medication : String )
  {
    self.bookId = bookId
    self.medication = medication
  }
  
  
  func toDictionary() -> [String : Any]
  {
    return[
      "bookId":self.bookId,
      "medication": self.medication
    ] as [String:Any]
  }
}
