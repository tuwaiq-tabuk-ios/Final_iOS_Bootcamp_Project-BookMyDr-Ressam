//
//  StartVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 09/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {
  
  var singUpButton: UIButton = {
    let btn = UIButton()
    btn.backgroundColor = .systemYellow
    btn.setTitleColor(.white, for: .normal)
    btn.setTitle("Sign Up".localized(), for: .normal)
    btn.titleLabel?.font = UIFont(name: "American Typewriter", size:31 )
    
    return btn
  }()
  
   var loginButton: UIButton = {
    let btn = UIButton()
    btn.backgroundColor = .systemYellow
    btn.setTitleColor(.white, for: .normal)
     btn.setTitle("Login".localized(), for: .normal)
     btn.titleLabel?.font = UIFont(name: "American Typewriter", size:31 )
     
    
    return btn
  }()
  
   var changeLanguegeSegmetedControl: UISegmentedControl = {
     let items = ["en" , "ar"]
     let SegmetedControl = UISegmentedControl(items: items)
     
     SegmetedControl.backgroundColor = UIColor.init(red: 255/255, green: 147/255, blue: 0/255, alpha: 1)
     
      if let languege = UserDefaults.standard.string(forKey: "currentLanguage"){
        switch languege {
        case "en":
          SegmetedControl.selectedSegmentIndex = 0
          UIView.appearance().semanticContentAttribute = .forceLeftToRight
          
        case "ar":
          SegmetedControl.selectedSegmentIndex = 1
          UIView.appearance().semanticContentAttribute = .forceLeftToRight
          
        default:
          let localLanguege = Locale.current.languageCode
          if localLanguege == "ar" {
            SegmetedControl.selectedSegmentIndex = 1
          } else {
            SegmetedControl.selectedSegmentIndex = 0
          }
        }
      } else {
        let localLanguege = Locale.current.languageCode
        UserDefaults.standard.setValue([localLanguege], forKey: "AppleLanguage")
        if localLanguege == "ar" {
          SegmetedControl.selectedSegmentIndex = 0
        } else{
          SegmetedControl.selectedSegmentIndex = 1
          }
        }
     return SegmetedControl
     
   }()
  
  var image : UIImageView = {
    let pImage = UIImageView()
    pImage.image = UIImage(named: "Manager.png")
    return pImage
  }()
  
  var label:UILabel = {
    let label  = UILabel()
    label.text = "Welcome to BookMyDr".localized()
    label.font = UIFont(name: "Hoefler Text Italic", size: 31.0)
    label.textColor = UIColor.init(red: 100/255, green: 181/225, blue: 234/255, alpha: 1)
    
    label.textAlignment = .center
    return label
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    changeLanguegeSegmetedControl.frame =  CGRect(x: (view.frame.width / 2) - 50, y: 73, width: 100, height: 32)
    view.addSubview(changeLanguegeSegmetedControl)
    image.frame =  CGRect(x: 0, y: 124, width: view.frame.width, height: 278)
    view.addSubview(image)
    label.frame = CGRect(x: 0, y: 456, width: view.frame.width, height: 40)
    view.addSubview(label)
    singUpButton.frame = CGRect(x: 20, y: view.frame.height - 170, width: (view.frame.width - 40), height: 70)
    loginButton.frame = CGRect(x: 20, y: view.frame.height - 90, width: (view.frame.width - 40), height: 70)
    
    view.addSubview(singUpButton)
    view.addSubview(loginButton)
    
    singUpButton.addTarget(self, action: #selector(singUpButton(_:)), for: .touchUpInside)
    loginButton.addTarget(self, action: #selector(btnloginButton(_:)), for: .touchUpInside)
    changeLanguegeSegmetedControl.addTarget(self, action: #selector(changeLanguage(_:)), for: .valueChanged)
    
    setUpElements()
  }
  
  
  func setUpElements() {
    Utilities.stylefilledButton(singUpButton)
    Utilities.stylefilledButton(loginButton)
  }
  
  
  @objc func changeLanguage(_ sender: UISegmentedControl) {
    
   
      if let lang = sender.titleForSegment(at: sender.selectedSegmentIndex)?.lowercased(){
      
        UserDefaults.standard.setValue(lang,
                                       forKey: "currentLanguage")
        
        Bundle.setLanguage(lang)
        
        let storyboard = UIStoryboard.init(name: "Main",
                                           bundle: nil)
        if let windowScane = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           
           let sceneDelegate = windowScane.delegate as? SceneDelegate {
          
          sceneDelegate.window?.rootViewController =
          storyboard.instantiateInitialViewController()

      }
    }
  }
  
  
  @objc func singUpButton(_ sender: Any) {
    
    let homeViewController = self.storyboard?
      .instantiateViewController(identifier:K.Storyboard.singUpController)
    
    self.view.window?.rootViewController = homeViewController
    self.view.window?.makeKeyAndVisible()
  }
  
  
  @objc func btnloginButton(_ sender: Any) {
    
    let homeViewController = self.storyboard?
      .instantiateViewController(identifier:K.Storyboard.loginController)
    
    self.view.window?.rootViewController = homeViewController
    self.view.window?.makeKeyAndVisible()
    
  }
}


extension String
{
  func localized() -> String
  {
    return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
  }
}
