//
//  LocationModel.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 15/05/1443 AH.
//

import Foundation

struct LocationModel {
  var locationId = String()
  var email : String
  var phone : String
  var adress :String
  
  init(value:NSDictionary)
  {
    self.locationId = value["locationId"] as! String
    self.email = value["email"] as! String
    self.phone = value["phone"] as! String
    self.adress = value["adress"] as! String
  }
  
  init(locationId:String , email :String , phone:String,adress:String ) {
    self.locationId = locationId
    self.email = email
    self.phone = phone
    self.adress = adress
  }
  
  
  func toDic()-> [String:Any]
  {
    return[
      "locationId": self.locationId,
      "email": self.email,
      "phone": self.phone,
      "adress": self.adress
    ]
  }
}
