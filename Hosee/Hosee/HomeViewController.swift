//
//  ViewController.swift
//  Hosee
//
//  Created by Minh Thang on 3/21/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import GooglePlacePicker
protocol HomeViewControllerDelegate: class {
    var isLeftSlideMenuOpen: Bool {get set}
    
}

class HomeViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet var workingSelectionView: WorkingSelectionView!
    @IBOutlet weak var selectedButton: Button!
    
    
    @IBOutlet weak var addressLabel: InfinityLoopLabelView!
    @IBOutlet weak var promoteBox: UIStackView!
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        return locationManager
    }()
    
    var delegate: HomeViewControllerDelegate?
    
    @IBOutlet weak var mapView: GMSMapView!
    var currentLocation: CLLocation?
    var zoomLevel: Float = 15.0
    var mapbounds:GMSCoordinateBounds? {
        if let visibleRegion = mapView?.projection.visibleRegion() {
            return GMSCoordinateBounds(coordinate: visibleRegion.farLeft, coordinate: visibleRegion.nearRight)
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWorkingSelectionView()
        setupLocationManager()
        addressLabel.text = "Bấm vào đây để chọn địa điểm!"
    }
    override func viewDidAppear(_ animated: Bool) {
        workingSelectionView.isOpen = false
    }
    
    @IBAction func createOrder(_ sender: UIButton) {
        sender.animate { (view) in
            
        }
       
        if let vc = UIStoryboard(name: "Booking", bundle: nil).instantiateViewController(withIdentifier: "booking") as? BookingViewController
        {
            vc.restString = addressLabel.text
            present(vc, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func onClickedMenu(_ sender: Any) {
         NotificationCenter.default.post(name: .toggle, object: nil, userInfo: nil)
    }
    
    @IBAction func onClickPromoteButton(_ sender: Any) {
        promoteBox.animate{ (success) in
            
        }
        
    }
    @IBAction func onClickPlace(_ sender: UIButton) {
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        present(placePicker, animated: true, completion: nil)
    }
    
}

extension HomeViewController: CLLocationManagerDelegate {
    
    
    func setupLocationManager() {
        let _ = locationManager
//        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        mapView.isHidden = true
    }
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        self.currentLocation = currentLocation
        print("Current Location: \(currentLocation)")
        
        let camera = GMSCameraPosition.camera(withLatitude: currentLocation.coordinate.latitude,
                                              longitude: currentLocation.coordinate.longitude,
                                              zoom: zoomLevel)
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
             mapView.isHidden = false
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
}

// MARK: - GMSPlacePickerViewControllerDelegate

extension HomeViewController: GMSPlacePickerViewControllerDelegate {
    // To receive the results from the place picker 'self' will need to conform to
    // GMSPlacePickerViewControllerDelegate and implement this code.
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        addressLabel.text = place.formattedAddress
        
        let camera2 = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 18.0)
        mapView.camera = camera2
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        print("No place selected")
    }
    
}
