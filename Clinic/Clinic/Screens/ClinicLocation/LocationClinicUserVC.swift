//
//  LocationClinicUserVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 22/05/1443 AH.
//

import UIKit
import MapKit
import FirebaseDatabase

class LocationClinicUserVC : UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  
  var ref : DatabaseReference!
  var locationList = [LocationModel]()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let initialLocation = CLLocation(latitude: 28.3905943,
                                     longitude: 36.5282448)
    
    setStartingLocation(location: initialLocation,
                        distance: 0)
    
    ref = Database.database().reference()
    
    addAnnotation()
    getData()
    setUpelement()
  }
  
  
  func setUpelement(){
    emailLabel.styleLabel()
    phoneLabel.styleLabel()
    addressLabel.styleLabel()
  }
  
  
  //Get the Clinic Information in Firebase
  func getData() {
    ref.child(K.FireStore.locationCollection).queryOrderedByKey()
      .observe(.value) { (snapshot) in
        
        if let snapshotVaue = snapshot.value as? NSDictionary,snapshot.exists(){
          let model = LocationModel(value: snapshotVaue)
           self.locationList.append(model)
           self.emailLabel.text = model.email
           self.phoneLabel.text = model.phone
          self.addressLabel.text = model.adress
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
    pin.coordinate = CLLocationCoordinate2D(latitude:28.3905943 ,
                                            longitude: 36.5282448)
    pin.title = "My Clinic"
    
    mapView.addAnnotation(pin)
  }
}
