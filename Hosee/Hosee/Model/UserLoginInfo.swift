//
//  UserObject.swift
//  Hosee
//
//  Created by huy on 05/04/2019.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import Foundation
struct UserLoginInfo: Decodable {
    let message: String
    let data: UserInfo
    
    struct UserInfo: Decodable {
        let access_token: String
        let client: clientInfo
        
        struct clientInfo: Decodable {
            let id: Int
            
        }
    }
}

struct User : Codable{
    var phoneNumber: String
    var password: String
    var latitude: Double
    var longtitude: Double
    var deviceID: String
    
    private enum CodingKeys: String, CodingKey {
        case phoneNumber = "phone_number"
        case password
        case latitude
        case longtitude
        case deviceID = "device_id"
    }
}
