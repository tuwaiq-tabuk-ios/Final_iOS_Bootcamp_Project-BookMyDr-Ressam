//
//  TimeViewController.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 24/05/1443 AH.
//

import UIKit

class TimeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
  var times = [String]()
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    let count = self.times.count
    return count
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    Staticv.instance.Time = (tableView.cellForRow(at: indexPath)?.textLabel!.text)!
    self.dismiss(animated: true, completion: nil)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "myCell")
    if !times.isEmpty {
      cell.textLabel!.text = times[indexPath.row]
    }
    
    return cell
  }
  

  @IBOutlet weak var timeTable: UITableView!
  override func viewDidLoad() {
        super.viewDidLoad()

    timeTable.delegate = self
    timeTable.dataSource = self
    }
    
  


}
