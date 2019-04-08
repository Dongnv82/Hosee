//
//  DataServiceLogin.swift
//  Hosee
//
//  Created by Duc Anh on 4/5/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit



class DataServices {
    
    static var sharedInstance = DataServices()
    
    func makeDataTaskRequest(user: String, pass: String, completeBlock:  @escaping (Promotion) -> Void) {
        
        let json = """
        {
        "phone_number": "\(user)",
        "password": "\(pass)",
        "latitude": 21.0335302,
        "longtitude":105.7678049,
        "device_id":"dx9ge4XZza8:APA91bFB-wPXpzbnKL-k9apPbAwqxkKbfj-pjX7dG5iL5vcpDVrvYKchZoyEUP3hYPo_cnoBf3Pr242NwHtIqT9kW4wOAQ5EgVN9ALIn6qIsQU4p9FlQhh2x9gs1dxVmUiD8F6uw6lb6"
        }
        """
        
        let url = "http://159.65.135.188:9670/clients/login"
        guard let urlString = URL(string: url) else {return}
        var urlRequest = URLRequest(url: urlString)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = json.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: urlRequest) {(data, _, error) in
            guard error == nil else {return}
            guard let aData = data else {return}
            do {
                let jSonObject = try JSONDecoder().decode(Promotion.self, from: aData)
                DispatchQueue.main.async {
                    completeBlock(jSonObject)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    
    
}

