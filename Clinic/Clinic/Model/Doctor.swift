//
//  DoctorModel.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 10/05/1443 AH.
//

import Foundation

struct Doctor {
  var doctorId : String!
  var doctorName : String!
  var clinicName : String!
  var hireDate : String!
  
  init(value : NSDictionary)
  {
    self.doctorId = value["doctorId"] as? String
    self.doctorName = value["doctorName"] as? String
    self.clinicName = value["clinicName"] as? String
    self.hireDate = value["hireDate"] as? String
  }
  
  init(doctorId:String,
       doctorName:String,
       clinicName:String,
       hireDate:String) {
    
    self.doctorId = doctorId
    self.doctorName = doctorName
    self.clinicName = clinicName
    self.hireDate = hireDate
  }
  
  
  func toDictionary() -> [String : Any]
  {
    return
      [ "doctorId" : self.doctorId!,
        "doctorName" : self.doctorName!,
        "clinicName" : self.clinicName!,
        "hireDate" : self.hireDate!] as [String:Any]
  }
}


