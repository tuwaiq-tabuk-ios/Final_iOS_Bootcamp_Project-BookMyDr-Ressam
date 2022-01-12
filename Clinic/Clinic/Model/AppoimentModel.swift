//
//  AppoimentModel.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 18/05/1443 AH.
//

import Foundation

struct AppoimentModel {
  var clinicName : String
  var doctorName: String
  var date : String
  var Time : String
  var isAvilable : Bool
  
  init(value:NSDictionary)
  {
    self.clinicName = value["clinicName"] as! String
    self.doctorName = value["doctorName"] as! String
    self.date = value["date"] as! String
    self.Time = value["time"] as! String
    self.isAvilable = value["isAvilable"] as! Bool
  }
  
  init( clinicName :String ,
        doctorName:String,
        date:String,
        Time:String,
        isAvilable:Bool ) {
   
    self.clinicName = clinicName
    self.doctorName = doctorName
    self.date = date
    self.Time = Time
    self.isAvilable = isAvilable
  }
  
  
  func toDic()-> [String:Any]
  {
    return[
      "clinicName": self.clinicName,
      "doctorName": self.doctorName,
      "date": self.date,
      "time": self.Time,
      "isAvilable": self.isAvilable
    ]as [String:Any]
  }
}
