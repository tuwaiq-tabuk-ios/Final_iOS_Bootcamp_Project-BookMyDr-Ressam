//
//  UILabel+Ext.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 26/05/1443 AH.
//

import UIKit

extension UILabel {
  
  
  func styleLabel (){
    
    let bottomLine  = CALayer()
    
    bottomLine.frame = CGRect(x: 0,
                              y: frame.height - 2,
                              width: frame.width,
                              height: 2)
    
    bottomLine.backgroundColor = UIColor.init(red: 255/255,
                                              green: 147/255,
                                              blue: 0/255,
                                              alpha: 1).cgColor
    
    layer.addSublayer(bottomLine)
  }
}


