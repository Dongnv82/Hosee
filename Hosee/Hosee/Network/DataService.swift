//
//  DataService.swift
//  KiemTien2
//
//  Created by daicudu on 3/20/19.
//  Copyright © 2019 daicudu. All rights reserved.
//

//import Foundation
//import GoogleMaps
//
//struct UserLoginInfo: Decodable {
//    let data: UserInfo
//    
//    struct UserInfo: Decodable {
//        let access_token: String
//        
//    }
//}
//
//class DataService {
//    static var shared: DataService = DataService()
//    func callAPILogin(phoneNumber: String, pass: String, latitude: CLLocationManager, longtitude: CLLocationManager, deviceID: String, completedHandler: @escaping(UserLoginInfo) -> Void) {
//        let url = URLFactory.login.URL
//        let parameters = """
//        {
//        "phone_number": "+\(phoneNumber)",
//        "password": "\(pass)",
//        "latitude": \(latitude),
//        "longtitude": \(longtitude),
//        "device_id": "\(deviceID)"
//        }
//        """
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "POST"
//        urlRequest.httpBody = parameters.data(using: .utf8)
//        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
//            guard error == nil else {return}
//            guard let aData = data else {return}
//            do {
//                let jSonObject = try JSONDecoder().decode(UserLoginInfo.self, from: aData)
//                DispatchQueue.main.async {
//                    completedHandler(jSonObject)
//                }
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//        downloadTask.resume()
//    }
//}

