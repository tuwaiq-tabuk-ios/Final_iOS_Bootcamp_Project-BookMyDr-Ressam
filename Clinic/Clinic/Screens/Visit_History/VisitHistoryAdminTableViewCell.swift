//
//  VisitHistoryAdminTableViewCell.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 06/06/1443 AH.
//

import UIKit

class VisitHistoryAdminTableViewCell: UITableViewCell {

  @IBOutlet weak var patientLabel: UILabel!
  @IBOutlet weak var doctorLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  var myCellDelegate : MyCellDelegate?
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  
  //Transfare to anouther view
  @IBAction func buttonTapped(_ sender: UIButton) {
    myCellDelegate?.didPressButton(sender.tag)
  }
    
}
