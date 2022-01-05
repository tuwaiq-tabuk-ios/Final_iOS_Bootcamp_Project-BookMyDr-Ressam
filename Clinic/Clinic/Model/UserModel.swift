//
//  UserModel.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 09/05/1443 AH.
//

import Foundation

struct UserModel : Codable {
  
  var uid : String!
  var firstName : String!
  var lastName : String!
  var email : String!
  var isAdmin : Bool!
}

