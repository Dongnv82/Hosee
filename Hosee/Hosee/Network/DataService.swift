//
//  DataService.swift
//  KiemTien2
//
//  Created by daicudu on 3/20/19.
//  Copyright © 2019 daicudu. All rights reserved.
//

import Foundation
class DataService {
    static var shared = DataService()
    
    func request<T: Codable>(url: URL, compleHandler: @escaping ([T]) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("co gi do sai sai")
                return
            }
            guard let data = data, response != nil else { return}
            
            do {
                guard let workingItems = try? JSONDecoder().decode([T].self, from: data) else {
                    print("dowload duoc roi nhung van sai")
                    return
                }
                DispatchQueue.main.async {
                    compleHandler(workingItems)
                }
                
            }catch let errorInfor{
                print("loi day nay: \(errorInfor)")
            }
        }.resume()
    }
}
