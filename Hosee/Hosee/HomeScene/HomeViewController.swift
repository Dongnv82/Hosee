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


class HomeViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet var workingSelectionView: WorkingSelectionView!
    @IBOutlet weak var addressContainerView: UIView!
    @IBOutlet weak var selectedWorkingTypeContainerView: UIView!
    @IBOutlet weak var addressLabel: InfinityLoopLabelView!
    @IBOutlet weak var promoteBox: UIStackView!
    @IBOutlet weak var orderStackView: UIStackView!
    
    @IBOutlet weak var promoButton: Button!
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        return locationManager
    }()
    
    var selectedPlace: GMSPlace? {
        didSet {
            guard let place = selectedPlace else {
                addressLabel.text = ConstantString.pickupPlacePlease
                return
            }
            addressContainerView.backgroundColor = UIColor.white
            addressLabel.text = place.formattedAddress
            let camera2 = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 18.0)
            mapView.camera = camera2
        }
    }
    
    var selectedWorkingType: WorkingType? {
        didSet {
            guard let selectedWorkingType = selectedWorkingType else {return }
            selectedWorkingTypeContainerView.backgroundColor = UIColor(hex: 0x007AFF)

        }
    }
    
    
    
    var selectedPromotion: Promo? {
        didSet {
            guard let selectedPromotion = selectedPromotion else {return}
            promoButton.setTitle(selectedPromotion.keyString, for: .normal)
        }
    }
    
    private var orderStack = [Order]() {
        didSet {
            let buttonOrder = orderStackView.arrangedSubviews.last
            orderStackView.arrangedSubviews.forEach{$0.removeFromSuperview()}
            orderStackView.addArrangedSubview(buttonOrder!)
            orderStack.forEach { (order) in
                var button = UIButton()
                button.backgroundColor = UIColor.orange
                button.setTitle(order.workingType.title, for: .normal)
                orderStackView.insertArrangedSubview(button, at: 0)
            }
           
        }
    }
    
    
    
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
        addressLabel.text = ConstantString.pickupPlacePlease
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewDidAppear(_ animated: Bool) {
        workingSelectionView.isOpen = false
    }
    
    @IBAction func createOrder(_ sender: UIButton) {
        sender.animate { (view) in
            
        }
        
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier {
        case SegueIdentifier.showBooking.rawValue:
            if selectedPlace == nil {
                addressContainerView.shake()
            }
            if selectedWorkingType == nil {
                selectedWorkingTypeContainerView.shake()
            }
            return selectedPlace != nil && selectedWorkingType != nil
        default:
            return true
        }
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case SegueIdentifier.showBooking.rawValue:
            let vc = segue.destination as! BookingViewController
            vc.restString = addressLabel.text
            vc.order = Order(workingType: selectedWorkingType!, place: selectedPlace!)
            vc.backToHome = { [weak self] in
                self?.orderStack.append(vc.order!)
                self?.selectedWorkingType = nil
                self?.selectedPlace = nil
            }
            vc.cancelOrderAction = {  [weak self] in
                self?.selectedWorkingType = nil
                self?.selectedPlace = nil
            }

        default:
            return
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
        selectedPlace = place
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        print("No place selected")
    }
    
}
