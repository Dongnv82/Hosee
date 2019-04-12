//
//  PromotionDataService.swift
//  Hosee
//
//  Created by duycuong on 4/10/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

typealias DICT = Dictionary<AnyHashable,Any>

class PromotionDataService {
    static var shared: PromotionDataService = PromotionDataService()
    
    func getData(pageNumber: Int, completedHandler: @escaping(Promo) -> Void) {
        
        let url = "http://159.65.135.188:9670/promo/list/\(pageNumber)/5"
        
        guard let urlString = URL(string: url) else {return}
        let urlRequest = URLRequest(url: urlString)
        
        let downloadTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, _, error) in
            guard error == nil else {return}
            guard let aData = data else {return}
            do {
                if let jSonObject = try JSONSerialization.jsonObject(with: aData, options: .mutableContainers) as? DICT {
                    DispatchQueue.main.async {
                        completedHandler(Promo(dictionary: jSonObject))
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        })
        downloadTask.resume()
    }
}
