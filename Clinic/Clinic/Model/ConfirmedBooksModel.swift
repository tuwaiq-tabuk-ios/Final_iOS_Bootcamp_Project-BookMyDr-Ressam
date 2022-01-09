//
//  ConfirmedBooksModel.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 05/06/1443 AH.
//

import Foundation

struct ConfirmedBooksModel {
  var bookId :String
  var userId :String
  var doctorId : String
  var date :String
  var time : String
  
  init(value : NSDictionary)
  {
    self.bookId = value["bookId"] as! String
    self.userId = value["userId"] as! String
    self.doctorId = value["doctorId"] as! String
    self.date = value["date"] as! String
    self.time = value["time"] as! String
  }
  
  init(bookId : String , userId : String , doctorId : String , date : String , time : String)
  {
    self.bookId = bookId
    self.userId = userId
    self.doctorId = doctorId
    self.date = date
    self.time = time
  }
  
  func toDic() -> [String : Any]
  {
    return[
      "bookId":self.bookId,
      "userId": self.userId,
      "doctorId": self.doctorId,
      "date":self.date,
      "time":self.time
    ] as [String : Any]
  }
                 
}

