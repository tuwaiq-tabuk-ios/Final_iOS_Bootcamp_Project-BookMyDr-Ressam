//
//  StartVC.swift
//  Clinic
//
//  Created by Ressam Al-Thebailah on 09/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var singUpButton: UIButton!
  @IBOutlet weak var loginButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setUpElements()
  }

  
  func setUpElements() {
    Utilities.stylefilledButton(singUpButton)
    Utilities.stylefilledButton(loginButton)
  }
}


// اضافه كومبيوتد للخبرات يكتب اول سنه اصبح دكتور الى هذا السنه
// اسم الدكتور و العياده يجون فاضيين بالداتا بيس
// ربط واجهات المستخدم مع البروجكت
// واجهه جديده لحجز موعد من غير التابل
//في الملف الطبي اضافه تاريخ الزياره و اضافه وصفه طبيه 
//مشكله الايرور في تسجيل الدخول ما يطلع
