//
//  DoctorsTableVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 11/05/1443 AH.
//

import UIKit
import FirebaseDatabase


class DoctorsTableVC: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var ref: DatabaseReference!
  var doctorList = [DoctorModel]()
  var myId = ""
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: "TableViewCell",
                             bundle: nil),
                       forCellReuseIdentifier: "TableViewCell")
    
    ref = Database.database().reference()
    
    getData()
  }
  
  
  //Get the doctor information from firebase
  private func getData() {
    ref.child(K.FireStore.doctorCollection).observe(.value, with: {
      DataShot in
      
      if DataShot.value != nil {
        
        if !self.doctorList.isEmpty {
          self.doctorList.removeAll()
        }
        
        if let data = DataShot.value as? NSDictionary{
          
          
          
          for (_,v) in data {
            let value = v as! NSDictionary
            
            self.doctorList.append(DoctorModel(value: value))
          }
        }
        self.tableView.reloadData()
      }
    }
    )}
  
  
  //Return to the previous view
  @IBAction func backButtonTapped(_ sender: UIButton) {
    self.dismiss(animated: true,
                 completion: nil)
  }
}


//MARK: - UITableViewDelegate,UITableViewDataSource

extension DoctorsTableVC : UITableViewDelegate,
                           UITableViewDataSource,
                           MyCellDelegate{
  
  
  //Delete cell row in table and firebase
  func tableView(_ tableView: UITableView,
                 trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
  -> UISwipeActionsConfiguration? {
    let delete = UIContextualAction(style: .destructive,
                                    title: "Delete") { ACTION,
                                                       view,
                                                       result in
      
      self.ref.child(K.FireStore.doctorCollection).child(self.doctorList[indexPath.row].doctorId).removeValue()
      result(true)
    }
    
    return UISwipeActionsConfiguration(actions: [delete])
  }
  
  
  //Show Doctors List(data) in table
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath)
  -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell",
                                             for: indexPath) as? TableViewCell
    
    cell?.myCellDelegate = self
    
    myId = self.doctorList[indexPath.row].doctorName
    cell?.bookingButton.tag = indexPath.row
    
    if !self.doctorList.isEmpty {
      
      cell?.clinicNameLabel.text = self.doctorList[indexPath.row].clinicName
      cell?.doctorNameLabel.text = self.doctorList[indexPath.row].doctorName
      cell?.yearsExpLabel.text = self.doctorList[indexPath.row].hireDate
    }
    
    cell?.backgroundColor = UIColor.init(red: 246/255, green: 246/255, blue: 212/255, alpha: 1)
    cell?.layer.cornerRadius = 25.0
    cell?.tintColor = UIColor.white
  cell?.layer.borderColor = UIColor.white.cgColor
   cell?.layer.borderWidth = 3
    cell?.bookingButton.layer.cornerRadius = 25.0
    cell?.clinicNameLabel.layer.cornerRadius = 25.0
    cell?.doctorNameLabel.layer.cornerRadius = 25.0
    cell?.yearsExpLabel.layer.cornerRadius = 25.0
   
    return cell!
  }
  
  
  //Transafer next View
  func didPressButton(_ tag: Int) {
    
    print("I have pressed a button with a tag: \(String(describing: self.doctorList[tag].doctorId))")
    
    let _ : UIStoryboard = UIStoryboard(name: "Main",
                                        bundle: nil)
    
    if let nextViewController = storyboard?.instantiateViewController(identifier: "AddBookVC") as? AddBookVC {
      
      nextViewController.doctorId = self.doctorList[tag].doctorId
      nextViewController.clinicName = self.doctorList[tag].clinicName
      nextViewController.doctorName = self.doctorList[tag].doctorName
      nextViewController.modalPresentationStyle = .fullScreen
      self.present(nextViewController,
                   animated: true,
                   completion: nil)
    }
  }
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    self.doctorList.count
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
}



