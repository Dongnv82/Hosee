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

protocol ViewCotrollerDelegate: class {
    var isLeftSlideMenuOpen: Bool {get set}
    
}

class ViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var khuyenMaiBtn: UIButton!
    @IBOutlet weak var ghiChuBtn: UIButton!
    
    weak var delegate: ViewCotrollerDelegate?
    var locationManager = CLLocationManager()
    var infoMarker = GMSMarker()
    
    @IBOutlet weak var myGMSMapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: 21.034491482594646, longitude: 105.76605074107647, zoom: 15.0)
        myGMSMapView.camera = camera
        infoMarker.position = CLLocationCoordinate2D(latitude: 21.034491482594646, longitude: 105.76605074107647)
        infoMarker.title = "KTX Mỹ Đình"
        infoMarker.snippet = "Hà Nội"
        infoMarker.map = myGMSMapView
        
        myGMSMapView.settings.myLocationButton = true
        myGMSMapView.settings.compassButton = true
        myGMSMapView.isMyLocationEnabled = true
        myGMSMapView.delegate = self
    }
    
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        let camera1 = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 15.0)
        mapView.animate(to: camera1)
        infoMarker.position = location
        infoMarker.isFlat = true
        infoMarker.title = name
        infoMarker.opacity = 0
        infoMarker.infoWindowAnchor.y = 1
        infoMarker.map = mapView
        mapView.selectedMarker = infoMarker
    }
    
    @IBAction func onClickBtn(_ sender: UIButton) {
        sender.animateToSmaller { (view) in
            
        }
    }
    @IBAction func leftSlideBtn(_ sender: Any) {
        delegate?.isLeftSlideMenuOpen = true
    }
    
}

