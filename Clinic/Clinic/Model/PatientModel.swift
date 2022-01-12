//
//  PeitentModel.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 17/05/1443 AH.
//

import Foundation

struct PatientModel {
  var bookId : String
  var clinicName : String
  var doctorName: String
  var name : String
  var phone : String
  var date : String
  var time : String
  var isAvilable : Bool
  
  init(value:NSDictionary)
  {
    self.bookId = value["bookId"] as! String
    self.clinicName = value["clinicName"] as! String
    self.doctorName = value["doctorName"] as! String
    self.name = value["name"] as! String
    self.phone = value["phone"] as! String
    self.date = value["date"] as! String
    self.time = value["time"] as! String
    self.isAvilable = value["isAvilable"] as! Bool
  }
  
  init(bookId:String ,
       clinicName :String ,
       doctorName:String,
       name:String,
       phone:String,
       date:String,
       time:String,
       isAvilable:Bool )
  {
    self.bookId = bookId
    self.clinicName = clinicName
    self.doctorName = doctorName
    self.name = name
    self.phone = phone
    self.date = date
    self.time = time
    self.isAvilable = isAvilable
  }
  
  
  func toDic()-> [String:Any]
  {
    return[
      "bookId": self.bookId,
      "clinicName": self.clinicName,
      "doctorName": self.doctorName,
      "name": self.name,
      "phone": self.phone,
      "date": self.date,
      "time": self.time,
      "isAvilable": self.isAvilable
    ]as [String:Any]
  }
}

