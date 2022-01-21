//
//  LocationClinicVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 15/05/1443 AH.
//

import UIKit
import MapKit
import FirebaseDatabase

class LocationClinicVC : UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  @IBOutlet weak var adressLabel: UILabel!
  
  var model = LocationModel()
  var ref : DatabaseReference!
  var locationList = [LocationModel]()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    ref = Database.database().reference()
    getData()
    setElements()
  }

  
  func setElements() {
    emailLabel.styleLabel()
    phoneLabel.styleLabel()
    adressLabel.styleLabel()
  }
  
  
  //Get the Clinic Information in Firebase
  func getData() {
    ref.child(K.FireStore.locationCollection).queryOrderedByKey()
      .observe(.value) { (snapshot) in
        
        if let snapshotVaue = snapshot.value as? NSDictionary,snapshot.exists(){
          self.model = LocationModel(value: snapshotVaue)
          self.locationList.append(self.model)
          self.emailLabel.text = self.model.email
          self.phoneLabel.text = self.model.phone
          self.adressLabel.text = self.model.adress
          let initialLocation = CLLocation(latitude: self.model.latitude,
                                           longitude: self.model.longitude)
          
          self.setStartingLocation(location: initialLocation,
                              distance: 0)
          
          self.addAnnotation()
        }
        
      }
  }
  
  
  //Define the boundaries of the area
  func setStartingLocation (location:CLLocation,
                            distance:CLLocationDistance) {
    let region = MKCoordinateRegion(center: location.coordinate,
                                    latitudinalMeters: distance,
                                    longitudinalMeters: distance)
    
    mapView.setRegion(region,
                      animated: true)
  }
  
  
  //Add coordinates and notation
  func addAnnotation() {
    let pin = MKPointAnnotation()
    
    pin.coordinate = CLLocationCoordinate2D(latitude:self.model.latitude ,
                                            longitude: self.model.longitude)
    pin.title = "My Clinic"
    
    mapView.addAnnotation(pin)
  }
}





