//
//  Order.swift
//  Hosee
//
//  Created by huy on 12/04/2019.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import Foundation
struct OrderInput: Codable {
    var clientID: Int
    var serviceType: Int
    var address: String
    var orderAt: Int?
    var promoCode: String?
    var notes: String?
    var lat: Float64
    var lng: Float64
    
    private enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
        case serviceType = "service_type"
        case address
        case orderAt = "order_at"
        case promoCode = "promo_code"
        case notes
        case lat
        case lng
    }
}

struct OrderCreated: Decodable {
    let code: Int
    
}
