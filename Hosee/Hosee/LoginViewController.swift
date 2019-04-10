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

    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    
    var deviceID = UIDevice.current.identifierForVendor!.uuidString
    var loginArray: [UserLoginInfo.UserInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    
    @IBAction func loginButton(_ sender: UIButton) {

        let user = User(phoneNumber: "+84924586555", password: "123456", latitude: (locationManager.location?.coordinate.latitude)!, longtitude: (locationManager.location?.coordinate.longitude)!, deviceID: UIDevice.current.identifierForVendor!.uuidString)
        DataService.shared.callAPILogin(user: user) { (userData) in
            UserDefaults.standard.data(forKey: "userInfo")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()

    }
    

}
