//
//  Constants.swift
//  WeLearn
//
//  Created by Ressam Al-Thebailah on 04/05/1443 AH.
//

import Foundation

struct K {
  
  struct Storyboard {
    static let userHomeViewController = "UserHomeVC"
    static let addBookUserVC = "AddBookUser"
    static let adminHomeController = "AdminHomeVC"
    static let logOutController = "logOutVC"
  }
  
  
  struct TableCell {
    static let timeReuseIdentifier = "myCell"
  }
  
  
  struct FireStore {
    static var userId = ""
    static let usersCollection = "users"
    static let availableBooksCollection = "availableBooks"
    static let confirmedBooksCollection = "confirmedBooks"
    static let patientCollection = "Patient"
    static let locationCollection = "Location"
    static let doctorCollection = "Doctor"
  }
}
