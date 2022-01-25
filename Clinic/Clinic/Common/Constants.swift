//
//  Constants.swift
//   Clinic
//
//  Created by Ressam Al-Thebailah on 04/05/1443 AH.
//

import Foundation

struct K {
  
  struct Storyboard {
    static let userHomeViewController = "UserHomeVC"
    static let addBookUserVC = "AddBookUser"
    static let adminHomeController = "AdminHomeVC"
    static let loginController = "loginVC"
    static let singUpController = "singUpVC"
    static let forgetPasswordVC = "forgetPasswordVC"
    static let addBookVC = "AddBookVC"
    static let addMedicationVC = "AddMedicationVC"
    static let medicationUserVC = "MedicationUserVC"
    static let locationClinicUserVC = "LocationClinicUserVC"
    static let visitHistoryTableUserVC = "VisitHistoryTableUserVC"
    static let doctorTableUserVC = "DoctorTableUserVC"
    static let visitHistoryTableAdminVC = "VisitHistoryTableAdminVC"
    static let locationClinicVC = "LocationClinicVC"
    static let doctorsTableVC = "DoctorsTableVC"
    
  }
  
  
  struct TableCell {
    static let timeReuseIdentifier = "myCell"
  }
  
  
  struct RealtimeDatabase {
    static var userId = ""
    static let usersCollection = "users"
    static let availableBooksCollection = "availableBooks"
    static let confirmedBooksCollection = "confirmedBooks"
    static let patientCollection = "Patient"
    static let locationCollection = "Location"
    static let doctorCollection = "Doctor"
    static let medicationCollection = "Medication"
  }
}
