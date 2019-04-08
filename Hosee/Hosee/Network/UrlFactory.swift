//
//  UrlFactory.swift
//  Hosee
//
//  Created by huy on 04/04/2019.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import Foundation


enum URLFactory: String {
    
    case login, promotion
    
    var URL : URL {
        func generalUrlComponent(path: String) -> URL {
            var urlComponent = URLComponents()
            urlComponent.scheme = "https"
            urlComponent.host = "159.65.135.188"
            urlComponent.port = 9678
            urlComponent.path = path
            return urlComponent.url!
        }
       
        switch self {
        case .login:
            return  generalUrlComponent(path: "/clients/login")
        case .promotion:
            return generalUrlComponent(path: "/clients/history/")
        }
    }
  
}





