//
//  ModelLogin.swift
//  Hosee
//
//  Created by Duc Anh on 4/5/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import Foundation

struct Promotion: Decodable {
    
    var code: Int
    var data: data
    
    struct data: Decodable {
        var access_token: String
        
    }
    
}
