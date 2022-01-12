//
//  ConfirmedBooksModel.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 05/06/1443 AH.
//

import Foundation

struct ConfirmedBooksModel {
  var bookId :String
  var userId :String
  var doctorId : String
  var date :String
  var time : String
  var haveMedication : Bool
  
  init(value : NSDictionary)
  {
    self.bookId = value["bookId"] as! String
    self.userId = value["userId"] as! String
    self.doctorId = value["doctorId"] as! String
    self.date = value["date"] as! String
    self.time = value["time"] as! String
    self.haveMedication = value["haveMedication"] as! Bool
  }
  
  init()
  {
    self.bookId = ""
    self.userId = ""
    self.doctorId = ""
    self.date = ""
    self.time = ""
    self.haveMedication = false
    
  }
  init(bookId : String ,
       userId : String ,
       doctorId : String ,
       date : String ,
       time : String,
       haveMedication:Bool)
  
  {
    self.bookId = bookId
    self.userId = userId
    self.doctorId = doctorId
    self.date = date
    self.time = time
    self.haveMedication = haveMedication
  }
  
  func toDic() -> [String : Any]
  {
    return[
      "bookId":self.bookId,
      "userId": self.userId,
      "doctorId": self.doctorId,
      "date":self.date,
      "time":self.time,
      "haveMedication" :self.haveMedication
    ] as [String : Any]
  }
                 
}

