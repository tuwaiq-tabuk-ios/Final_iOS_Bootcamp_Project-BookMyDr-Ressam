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
  
  var ref : DatabaseReference!
  var locationList = [LocationModel]()
  
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  @IBOutlet weak var adressLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let initialLocation = CLLocation(latitude: 28.3905943,
                                     longitude: 36.5282448)
    
    setStartingLocation(location: initialLocation,
                        distance: 0)
    
    addAnnotation()
    
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
        let snapshotVaue = snapshot.value as? NSDictionary
        
        let locationId = snapshotVaue? ["locationId"] as? String
        let email = snapshotVaue?["email"] as? String
        let phone = snapshotVaue?["phone"] as? String
        let adress = snapshotVaue?["adress"] as? String
        self.emailLabel.text = email
        self.phoneLabel.text = phone
        self.adressLabel.text = adress
        self.locationList.append(LocationModel(locationId: locationId!,
                                               email: email,
                                               phone: phone,
                                               adress: adress))
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
  
  
  // add Add coordinates and notation
  func addAnnotation() {
    let pin = MKPointAnnotation()
    pin.coordinate = CLLocationCoordinate2D(latitude:28.3905943 ,
                                            longitude: 36.5282448)
    pin.title = "My Clinic"
    mapView.addAnnotation(pin)
  }
}
