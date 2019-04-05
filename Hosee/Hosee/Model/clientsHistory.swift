//
//  clientsHistory.swift
//  Hosee
//
//  Created by huy on 05/04/2019.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import Foundation

struct clientsHistory: Decodable {
    var data: [historyData]
    
    struct historyData: Decodable {
        var id: Int
        var partner: partnerInfo
        var service_type: Int
        var address: String
        var charge_amount: Int
        var client_rating: Int
        
        struct partnerInfo: Decodable {
            var phone_number: String
            var display_name: String
        }
    }
}
