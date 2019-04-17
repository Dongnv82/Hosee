//
//  PromotionModel.swift
//  Hosee
//
//  Created by duycuong on 4/10/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import Foundation



struct PromoService : Codable {
    var count: Int?
    var message: String?
    var data: [Promo] = []
    
    private enum CodingKeys: String, CodingKey {
        case count = "count"
        case message = "message"
        case data
    }
}

struct Promo : Codable {
    var id: Int
    var keyString: String?
    var availableTo: String?
    private enum CodingKeys: String, CodingKey {
        case id
        case keyString = "key_string"
        case availableTo = "available_to"
    }
}


