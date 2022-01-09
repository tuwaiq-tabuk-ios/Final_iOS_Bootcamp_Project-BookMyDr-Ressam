//
//  UserModel.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 09/05/1443 AH.
//

import Foundation

struct UserModel {
  var uid : String
  var firstName : String
  var lastName : String
  var email : String
  var isAdmin : Bool
  
  init(value : NSDictionary)
  {
    self.uid = value["Id"] as! String
    self.firstName = value["firstName"] as! String
    self.lastName = value["lastName"] as! String
    self.email = value["email"] as! String
    self.isAdmin = value["isAdmin"] as! Bool
  }
  
  init(uid:String,
       firstName:String,
       lastName:String,
       email:String,
       isAdmin:Bool
       ) {
    
    self.uid = uid
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
    self.isAdmin = isAdmin
    
  }
  
  
  func toDic() -> [String : Any]
  {
    return
      [ "Id" : self.uid,
        "firstName" : self.firstName,
        "lastName" : self.lastName,
        "email" : self.email,
       " isAdmin" : self.isAdmin
      ]as [String:Any]
    
        
  }
}

