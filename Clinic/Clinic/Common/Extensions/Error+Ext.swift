//
//  Error+Ext.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 25/05/1443 AH.
//

import Foundation


enum CustomError: Error {
  
  // Throw when Textfields are empty
  case emptyFields
  
  // Throw when an invalid password is entered
  case invalidSyntaxPassword
  
  // Throw when an invalid password is entered
  case invalidPassword
  
  // Throw when an expected resource is not found
  case notFound
  
  // Throw in all other cases
  case unexpected(code: Int)
}


extension CustomError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .emptyFields:
      return NSLocalizedString(
        "Please fill in all fields.",
        comment: "Invalid Textfields"
      )
    case .invalidSyntaxPassword:
      return NSLocalizedString(
        "Please make sure your password is at least 8 characters, contains a special charactar and a number.",
        comment: "Invalid Suntax Password"
      )
    case .invalidPassword:
      return NSLocalizedString(
        "The provided password is not valid.",
        comment: "Invalid Password"
      )
    case .notFound:
      return NSLocalizedString(
        "The specified item could not be found.",
        comment: "Resource Not Found"
      )
    case .unexpected(_):
      return NSLocalizedString(
        "An unexpected error occurred.",
        comment: "Unexpected Error"
      )
    }
  }
}

