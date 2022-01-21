//
//  TimeVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 25/05/1443 AH.
//

import UIKit

class TimeVC: UIViewController,
              UITableViewDelegate,
              UITableViewDataSource {
  
  @IBOutlet weak var timeTable: UITableView!
  
  var times = [String]()
  
  override func viewDidDisappear(_ animated: Bool) {
    self.times.removeAll()
  }
  
  @objc func dismissSelf()
  {
    self.dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissSelf))
    timeTable.delegate = self
    timeTable.dataSource = self
  }
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    let count = self.times.count
    return count
  }
  
  
  // Return to the previous view
  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    Staticv.instance.Time = (tableView.cellForRow(at: indexPath)?.textLabel!.text)!
    self.times.removeAll()
    tableView.reloadData()
    self.dismiss(animated: true, completion: nil)
  }
  
  
  //Show the time available for each doctor
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default,
                               reuseIdentifier: K.TableCell.timeReuseIdentifier)
    if !times.isEmpty {
      cell.textLabel!.text = times[indexPath.row]
    }
    
    return cell
  }
  
  
  @IBAction func hidingButton(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
}
