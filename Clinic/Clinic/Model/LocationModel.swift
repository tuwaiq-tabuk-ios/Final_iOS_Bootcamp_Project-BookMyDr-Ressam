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
  var latitude : Double
  var longitude : Double
    
  init(value:NSDictionary)
  {
    self.locationId = value["locationId"] as! String
    self.email = value["email"] as! String
    self.phone = value["phone"] as! String
    self.adress = value["adress"] as! String
      self.latitude = value["latitude"] as! Double
      self.longitude = value["longitude"] as! Double
      
  }
  init( )
  {
    self.locationId = ""
    self.email = ""
    self.phone = ""
    self.adress = ""
    self.latitude = 0.0
    self.longitude = 0.0
  }
  init(locationId:String ,
       email :String ,
       phone:String,
       adress:String,
       lat : Double,
       long : Double )
  {
    self.locationId = locationId
    self.email = email
    self.phone = phone
    self.adress = adress
      self.latitude = lat
      self.longitude = long
  }
  
  
  func toDic()-> [String:Any]
  {
    return[
      "locationId": self.locationId,
      "email": self.email,
      "phone": self.phone,
      "adress": self.adress,
      "latitude" : self.latitude,
      "longitude" : self.longitude
    ]
  }
}
