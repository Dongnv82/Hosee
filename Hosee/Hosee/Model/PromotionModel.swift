//
//  PromotionModel.swift
//  Hosee
//
//  Created by duycuong on 4/10/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import Foundation

struct Promo {
    var count: Int?
    var data: [PromoData] = []
    
    var mess: String?
    
    init(dictionary: DICT) {
        count = dictionary["count"] as? Int ?? 0
        mess = dictionary["message"] as? String ?? ""
        let arrayData = dictionary["data"] as? [DICT] ?? []
        
        for promoData in arrayData {
            self.data.append(PromoData(dictionary: promoData))
        }
        
    }
    
}

struct PromoData {
    var keyString: String?
    var availableTo: String?
    init(dictionary: DICT) {
        keyString = dictionary["key_string"] as? String ?? ""
        availableTo = dictionary["available_to"] as? String ?? ""
    }
}
