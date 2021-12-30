//
//  TableViewCellUser.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 19/05/1443 AH.
//

import UIKit

class TableViewCellUser: UITableViewCell {
  
  @IBOutlet weak var doctorNameLabel: UILabel!
  @IBOutlet weak var clinicNameLabel: UILabel!
  @IBOutlet weak var yearsOfExperienceLabel: UILabel!
  @IBOutlet weak var bookButton: UIButton!
  
  var myCellDelegate : MyCellDelegate?
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  
  override func setSelected(_ selected: Bool,
                            animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  
  @IBAction func buttonPressed(_ sender : UIButton) {
    myCellDelegate?.didPressButton(sender.tag)
  }

}
