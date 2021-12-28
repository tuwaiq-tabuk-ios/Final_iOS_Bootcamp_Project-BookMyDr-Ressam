//
//  DoctorsTableViewController.swift
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
  
  
  private func getData()
  {
    ref.child("Doctor").observe(.value, with: {
                                  DataShot in
      
      if DataShot.value != nil
      {
        if !self.doctorList.isEmpty
        {
          self.doctorList.removeAll()
        }
        let data = DataShot.value as? NSDictionary
        
        var DoctorId = ""
        var DoctorName = ""
        var ClinicName = ""
        var YearsOfExperince = ""
        
        for (_,v) in data!
        {
          for (key,val) in v as! NSDictionary {
            
            if key as! String == "DoctorId"
            {
              DoctorId = val as! String
            }
            else if key as! String == "DoctorName"
            {
              DoctorName = val as! String
            }
            else if key as! String == "ClinicName"
            {
              ClinicName = val as! String
            }
            else if key as! String == "YearsOfExperience"
            {
              YearsOfExperince = val as! String
            }
          }
          
          self.doctorList.append(DoctorModel(DoctorId: DoctorId, DoctorName: DoctorName, ClinicName: ClinicName, YearsOfExperience: YearsOfExperince))
        }
      }
      
      self.tableView.reloadData()
    }
  )}
  
  
  
  @IBAction func backButtonTapped(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
}


//MARK: - UITableViewDelegate,UITableViewDataSource

extension DoctorsTableVC : UITableViewDelegate,
                           UITableViewDataSource,
                           MyCellDelegate
{
  
  
  func tableView(_ tableView: UITableView,
    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
  -> UISwipeActionsConfiguration?
  {
    let delete = UIContextualAction(style: .destructive,
                                    title: "Delete") { ACTION,
                                                       view,
                                                       result in
      self.ref.child("Doctor").child(self.doctorList[indexPath.row].DoctorId).removeValue()
      result(true)
    }
   return UISwipeActionsConfiguration(actions: [delete])
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath)
  -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell",
                                             for: indexPath) as? TableViewCell
    cell?.myCellDelegate = self
    
    myId = self.doctorList[indexPath.row].DoctorName
    cell?.bookingButton.tag = indexPath.row
    
    if !self.doctorList.isEmpty
    {
      cell?.clinicNameLabel.text = self.doctorList[indexPath.row].ClinicName
      cell?.doctorNameLabel.text = self.doctorList[indexPath.row].DoctorName
      cell?.yearsExpLabel.text = self.doctorList[indexPath.row].YearsOfExperience
    }
    
    return cell!
  }
  
  
  func didPressButton(_ tag: Int)
  {
    print("I have pressed a button with a tag: \(self.doctorList[tag].DoctorId)")
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main",
                                                 bundle: nil)
    
    if let nextViewController = storyboard?.instantiateViewController(identifier: "AddBookVC") as? AddBookVC
    {
      nextViewController.doctorId = self.doctorList[tag].DoctorId
      nextViewController.clinicName = self.doctorList[tag].ClinicName
      nextViewController.doctorName = self.doctorList[tag].DoctorName
      nextViewController.modalPresentationStyle = .fullScreen
      self.present(nextViewController,
                   animated: true,
                   completion: nil)
    }
  }
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int)
  -> Int {
    self.doctorList.count
  }
  
  
  func numberOfSections(in tableView: UITableView)
  -> Int {
    1
  }
  
}


  //TODO:Delet Row in Table And Database
  //  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
  //
  //    if editingStyle == .delete {
  //      let doctorRow = doctorList[indexPath.row]
  //
  //    }
  //  }
  

