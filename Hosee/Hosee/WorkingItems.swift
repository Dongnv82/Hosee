//
//  WorkingItems.swift
//  KiemTien2
//
//  Created by daicudu on 3/19/19.
//  Copyright © 2019 daicudu. All rights reserved.
//

import Foundation

typealias JSON =  Dictionary<String,Any>
struct WorkingItem {
    var code: String
    var location: String
    var task: String
    var partner: Partner
    var price: Double
    var rating: Int
    var time: TimeInterval
    private enum CodingKeys: String, CodingKey {
        case code = "1"
        case location = "2"
        case task = "3"
        case partner = "4"
        
    }
}

struct Partner {
    var name: String
    var phone: String
    
//    init(dict: JSON) {
//        <#statements#>
//    }
}

