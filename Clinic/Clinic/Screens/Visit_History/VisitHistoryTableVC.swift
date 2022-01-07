//
//  VisitHistoryTableVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 01/06/1443 AH.
//

import UIKit

class VisitHistoryTableVC: UITableViewCell {
  
  @IBOutlet weak var doctorLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var detailsButton: UIButton!
  
  var myCellDelegate : MyCellDelegate?
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  
  override func setSelected(_ selected: Bool,
                            animated: Bool) {
    super.setSelected(selected,
                      animated: animated)
  }
  
  
  //Transfare to anouther view
  @IBAction func buttonTapped(_ sender: UIButton) {
    myCellDelegate?.didPressButton(sender.tag)
  }
}
