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
  var patientName : String
  var patientMobile : String
  init(value : NSDictionary)
  {
    self.bookId = value["bookId"] as! String
    self.userId = value["userId"] as! String
    self.doctorId = value["doctorId"] as! String
    self.date = value["date"] as! String
    self.time = value["time"] as! String
    self.haveMedication = value["haveMedication"] as! Bool
    self.patientName = value["patientName"] as! String
    self.patientMobile = value["patientMobile"] as! String
  }
  
  init()
  {
    self.bookId = ""
    self.userId = ""
    self.doctorId = ""
    self.date = ""
    self.time = ""
    self.haveMedication = false
    self.patientName = ""
    self.patientMobile = ""
  }
  
  init(bookId : String ,
       userId : String ,
       doctorId : String ,
       date : String ,
       time : String,
       haveMedication:Bool,
       patientName : String ,
       patientMobile : String )
  
  {
    self.bookId = bookId
    self.userId = userId
    self.doctorId = doctorId
    self.date = date
    self.time = time
    self.haveMedication = haveMedication
    self.patientName = patientName
    self.patientMobile = patientMobile
  }
  
  func toDictionary() -> [String : Any]
  {
    return[
      "bookId":self.bookId,
      "userId": self.userId,
      "doctorId": self.doctorId,
      "date":self.date,
      "time":self.time,
      "haveMedication" :self.haveMedication,
      "patientName" :self.patientName,
      "patientMobile" :self.patientMobile
    ] as [String : Any]
  }
                 
}

