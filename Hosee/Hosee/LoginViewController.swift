//
//  LoginViewController.swift
//  Hosee
//
//  Created by Duc Anh on 4/2/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
class LoginViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var phoneNumberLabel: UITextField!
    @IBOutlet weak var passWordLabel: UITextField!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    var deviceID = UIDevice.current.identifierForVendor!.uuidString
    var loginArray: [UserLoginInfo.UserInfo] = []
    var latitude: Double?
    var longitude: Double?
    var message: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
       message = nil
    }

    
    @IBAction func loginButton(_ sender: UIButton) {
        
        let phoneNumber: String = "\(phoneNumberLabel.text?.dropFirst() ?? "")"
        let user = User(phoneNumber: "+84\(phoneNumber)", password: passWordLabel.text!, latitude: latitude!, longtitude: longitude!, deviceID: UIDevice.current.identifierForVendor!.uuidString)
        if phoneNumberLabel.text != "" && passWordLabel.text != "" {
            if phoneNumberLabel.text?.count == 10 {
                DataService.shared.callAPILogin(user: user) { (userData) in
                    UserDefaults.standard.data(forKey: "userInfo")
                    self.message = userData.message
                }
                checkUserLogin(message: message)
            } else {
                showAlert(title: "", message: "Số điện thoại nhập chưa chính xác")
            }
        } else {
            showAlert(title: "", message: "Số điện thoại nhập chưa chính xác")
        }
        
    }
    
    func checkUserLogin(message: String?) {
        if message != nil {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main") as? ContainerViewController {
                present(vc, animated: true, completion: nil)
            }
        } else {
            showAlert(title: "", message: "tài khoản không tồn tại")
        }
        
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
            showAlertToOpenSetting(title: "yeu cau truy cap", message: "ban hay cap phep")

        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
             showAlertToOpenSetting(title: "yeu cau truy cap", message: "ban hay cap phep")
        case .notDetermined:
            print("Location status not determined.")
//            showAlertToOpenSetting(title: "yeu cau truy cap", message: "ban hay cap phep")
            self.locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        latitude = location?.coordinate.latitude
        longitude = location?.coordinate.longitude
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()

    }
    
}
