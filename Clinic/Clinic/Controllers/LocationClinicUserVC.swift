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
  
  
  override func viewDidLoad(){
    super.viewDidLoad()
    
    let initialLocation = CLLocation(latitude: 28.3905943,
                                     longitude: 36.5282448)
    
    setStartingLocation(location: initialLocation,
                        distance: 0)
    
    addAnnotation()
    
    ref = Database.database().reference()
    getData()
  }
  
  
  func getData()
  {
    ref.child("Location").queryOrderedByKey()
      .observe(.value) { (snapshot) in
        let snapshotVaue = snapshot.value as? NSDictionary
        
        let locationId = snapshotVaue? ["locationId"] as? String
        let email = snapshotVaue?["email"] as? String
        let phone = snapshotVaue?["phone"] as? String
        let adress = snapshotVaue?["adress"] as? String
        self.emailLabel.text = email
        self.phoneLabel.text = phone
        self.addressLabel.text = adress
        self.locationList.append(LocationModel(locationId: locationId!,
                                               email: email,
                                               phone: phone,
                                               adress: adress))
      }
  }
  
  
  func setStartingLocation (location:CLLocation,
                            distance:CLLocationDistance)
  {
    let region = MKCoordinateRegion(center: location.coordinate,
                                    latitudinalMeters: distance,
                                    longitudinalMeters: distance)
    
    mapView.setRegion(region,
                      animated: true)
  }
  
  
  func addAnnotation()
  {
    let pin = MKPointAnnotation()
    pin.coordinate = CLLocationCoordinate2D(latitude:28.3905943 ,
                                            longitude: 36.5282448)
    pin.title = "My Clinic"
    mapView.addAnnotation(pin)
  }
  
}
