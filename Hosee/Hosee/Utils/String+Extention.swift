//
//  String+Extention.swift
//  Hosee
//
//  Created by Duc Anh on 4/12/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import Foundation

extension String {
    var toDate: Date {
        get {
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormater.locale = Locale(identifier: "vi_VN")
            let date = dateFormater.date(from: self)
            return date!
        }
    }
}
