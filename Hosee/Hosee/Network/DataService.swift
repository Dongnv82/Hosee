//
//  DataService.swift
//  Hosee
//
//  Created by huy on 05/04/2019.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import Foundation



class DataService {
    static var shared: DataService = DataService()
    func callAPILogin(user: User,  completedHandler: @escaping(UserLoginInfo) -> Void) {
        let url = URLFactory.login.URL
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("", forHTTPHeaderField: "Authorization")
        let data = try? JSONEncoder().encode(user)
        
        let uploadTask = URLSession.shared.uploadTask(with: urlRequest, from: data)  { (data, response , error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let aData = data else {return}
            do {
                let jSonObject = try JSONDecoder().decode(UserLoginInfo.self, from: aData)
                DispatchQueue.main.async {
                    completedHandler(jSonObject)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        uploadTask.resume()
    }
    
    func callAPIHistory(userID: Int,  completedHandler: @escaping(clientsHistory) -> Void) {
        let url = URL(string: URLFactory.history.URL.absoluteString + "\(userID)")
        print(url)
        var urlRequest = URLRequest(url: url!)
//        urlRequest.httpMethod = "GET"
//        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
//        urlRequest.addValue("57UFoOdYCw1mQaLM3QrdV8__rHQCVWZayZqx-3cFHvE", forHTTPHeaderField: "Authorization")
        let uploadTask = URLSession.shared.dataTask(with: urlRequest)  { (data, response , error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let aData = data else {return}
            do {
                let jSonObject = try JSONDecoder().decode(clientsHistory.self, from: aData)
                DispatchQueue.main.async {
                    completedHandler(jSonObject)
                }
            } catch {
                print(error)
            }
        }
        uploadTask.resume()
    }
}
