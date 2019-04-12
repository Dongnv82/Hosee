//
//  UrlFactory.swift
//  Hosee
//
//  Created by huy on 04/04/2019.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import Foundation


enum URLFactory: String {
    //nơi khai báo case
    case login, promotion, history
    
    //những thành phần gép lại thành baseURL
    var URL : URL {
        func generalUrlComponent(path: String) -> URL {
            var urlComponent = URLComponents()
            urlComponent.scheme = "http"
            urlComponent.host = "159.65.135.188"
            urlComponent.port = 9670
            urlComponent.path = path
            return urlComponent.url!
        }
       
        //viết path để gọi đuôi URL tại đây
        switch self {
        case .login:
            return  generalUrlComponent(path: "/clients/login")
        case .promotion:
            return generalUrlComponent(path: "/promo/list/")
        case .history:
            return generalUrlComponent(path: "/clients/history/")
        }
    }
  
}



