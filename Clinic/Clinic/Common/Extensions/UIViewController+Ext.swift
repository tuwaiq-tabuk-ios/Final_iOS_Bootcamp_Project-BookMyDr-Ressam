//
//  UIViewController+Ext.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 11/05/1443 AH.
//

import UIKit

extension UIViewController {
  
  
  func showaAlertDoneView(Title: String,
                          Msg: String) {
    let alert = UIAlertController(title: Title,
                                  message: Msg,
                                  preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "Close",
                                  style: .default,
                                  handler: { action in
                                    print("Cancel clicked")
      alert.dismiss(animated: true, completion: nil)

      
    }))
    
    self.present(alert, animated: true,
                 completion: nil)
  }
  
}
