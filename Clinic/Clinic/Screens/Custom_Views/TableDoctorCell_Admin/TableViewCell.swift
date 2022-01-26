//
//  TableViewCell.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 11/05/1443 AH.
//

import UIKit


class TableViewCell: UITableViewCell {
  
  @IBOutlet weak var doctorNameLabel: UILabel!
  @IBOutlet weak var clinicNameLabel: UILabel!
  @IBOutlet weak var yearsExpLabel: UILabel!
  @IBOutlet weak var bookingButton: UIButton!
  
  var myCellDelegate : MyCellDelegate?
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  
  override func setSelected(_ selected: Bool,
                            animated: Bool) {
    super.setSelected(selected,
                      animated: animated)
  }
  
  
  //Transfare to another view
  @IBAction func buttonPressed(_ sender : UIButton) {
    myCellDelegate?.didPressButton(sender.tag)
  }
}
