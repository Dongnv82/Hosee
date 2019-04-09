//
//  clientsHistory.swift
//  Hosee
//
//  Created by huy on 05/04/2019.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import Foundation

struct clientsHistory: Codable {
    var data: [HistoryData]
    
    struct HistoryData: Codable {
        var id: Int
        var partner: PartnerInfo
        var service_type: Int
        var address: String
        var charge_amount: Int
        var client_rating: Int
        
        struct PartnerInfo: Codable {
            var phone_number: String
            var display_name: String
        }
    }
}
