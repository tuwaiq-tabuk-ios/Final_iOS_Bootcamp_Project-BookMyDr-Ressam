//
//  EditLocationVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 15/05/1443 AH.
//

import UIKit
import FirebaseDatabase
import MapKit

class EditLocationVC: UIViewController ,UIGestureRecognizerDelegate{
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var phoneTextField: UITextField!
  @IBOutlet weak var adressTextField: UITextField!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var mapView: MKMapView!
  
  var pin = MKPointAnnotation()
  var modelList = [Location]()
  var ref : DatabaseReference!
  var latude = 0.0 , longtude = 0.0
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let gestureRecognizer =
    UILongPressGestureRecognizer(target: self,
                                 action:#selector
                                 (self.triggerTouchAction(gestureReconizer:)))
    
    mapView.isZoomEnabled = true
    mapView.isPitchEnabled = true
    mapView.addGestureRecognizer(gestureRecognizer)
    
    adressTextField.delegate = self
    
    ref = Database.database().reference()
    
    tableView.dataSource = self
    tableView.delegate = self
    
    gestureRecognizer.delegate = self
    
    let zoomGestur =
    UIPinchGestureRecognizer(target: self,
                             action: #selector(zoomTracking(pitchGestur:)))
    zoomGestur.delegate = self
    
    setUpElements()
  }
  
  
  @objc func zoomTracking(pitchGestur : UIPinchGestureRecognizer) {
    
    if pitchGestur.state ==
        UIPinchGestureRecognizer.State.began
    {
      var region: MKCoordinateRegion = mapView.region
      var span = MKCoordinateSpan()
      
      span.latitudeDelta = region.span.latitudeDelta * 2
      
      span.longitudeDelta = region.span.longitudeDelta * 2
      
      region.span = span
    }
  }
  
  
  @objc func triggerTouchAction
  ( gestureReconizer: UILongPressGestureRecognizer) {
    
    if gestureReconizer.state !=
        UILongPressGestureRecognizer.State.ended
    {
      let totuchLocation  =
      gestureReconizer.location(in: mapView)
      
      let locationCordinate =
      mapView.convert(totuchLocation,
                      toCoordinateFrom: mapView)
      
      mapView.removeAnnotation(pin)
      pin.coordinate = locationCordinate
      pin.title = "My Clinic"
      mapView.addAnnotation(pin)
      
      self.latude = locationCordinate.latitude
      self.longtude = locationCordinate.longitude
    }
  }
  
  
  func setUpElements(){
    emailTextField.styleTextField()
    phoneTextField.styleTextField()
    adressTextField.styleTextField()
  }
  
  
  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    emailTextField.resignFirstResponder()
    phoneTextField.resignFirstResponder()
    adressTextField.resignFirstResponder()
  }
  
  
  @IBAction func doneButtonTapped(_ sender: UIButton) {
    
    //Not have error update the clinic information in Firebase
    let locationId = UUID.init().uuidString
    let location = LocationM(locationId:locationId,
                                 email:self.emailTextField.text!,
                                 phone:self.phoneTextField.text!, adress:self.adressTextField.text!,
                                 lat: self.latude,long: self.longtude)
    
    self.ref .child(K.RealtimeDatabase.locationCollection)
      .setValue(location.toDictionary())
    { [self] error, DataRef in
      if error == nil {
        
        self.showaAlertDoneView(Title: "Done!",
                                Msg: "Changed successfully")
      } else {
        self.showaAlertDoneView(Title: "Error!",
                                Msg: error.debugDescription)
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
  func addAnnotation(location:CLLocation) {
    
    
    pin.coordinate = CLLocationCoordinate2D(latitude:location.coordinate.latitude ,
                                            longitude: location.coordinate.longitude)
    pin.title = "My Clinic"
    
    mapView.addAnnotation(pin)
  }
  
  static let shared = CLLocationManager()
  
  public func findLocations(with query : String ,
                            completion : @escaping (([Location]) -> Void))
  {
    let geoCoder = CLGeocoder()
    geoCoder.geocodeAddressString(query) { places,
      error in
      guard let places = places ,
            error == nil else {
              completion([])
              return
            }
      
      let models : [Location] = places.compactMap( { place in
        var name = ""
        
        if let locationName  = place.name {
          name += locationName
        }
        
        if let adminRegion = place.administrativeArea {
          name += ",\(adminRegion)"
        }
        
        if let locality = place.locality {
          name += ",\(locality)"
        }
        
        if let country = place.country {
          name += ",\(country)"
        }
        
        let result  = Location(title: name,
                               coordinates: place.location!.coordinate)
        
        return result
      })
      completion(models)
    }
  }
}


//MARK: -  UITableViewDelegate , UITableViewDataSource
extension EditLocationVC : UITableViewDelegate ,
                           UITableViewDataSource {
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    self.modelList.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
    
    cell!.textLabel!.text = self.modelList[indexPath.row].title
    
    return cell!
  }
  
  
  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    
    print("Cell Selected")
    
    self.latude = self.modelList[indexPath.row].coordinates.latitude
    self.longtude = self.modelList[indexPath.row].coordinates.longitude
    
    let locationCordinate = CLLocation(latitude: self.latude,
                                       longitude: self.longtude)
    
    setStartingLocation(location: locationCordinate ,
                        distance: 0.7)
    
    addAnnotation(location: locationCordinate)
    
  }
}

//MARK: - UITextFieldDelegate
extension EditLocationVC : UITextFieldDelegate
{
  
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    self.adressTextField.resignFirstResponder()
    
    print("text Was Edititng")
    
    if let address = self.adressTextField.text,
       !adressTextField.text!.isEmpty {
      
      findLocations(with: address) { locations in
        self.modelList = locations
        self.tableView.reloadData()
      }
    }
    return true
  }
}


struct Location
{
  let title : String
  let coordinates : CLLocationCoordinate2D
}





