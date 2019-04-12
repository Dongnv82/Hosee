//
//  File.swift
//  Hosee
//
//  Created by Duc Anh on 4/10/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import Foundation
class DataService {
    static var shared: DataService = DataService()
    let accessToken = String.loadFromUserDefaults(withKey: Keys.access_token.rawValue)

    func callAPILogin(user: User,  completedHandler: @escaping(UserLoginInfo) -> Void) {
        LoadingView.start()
        let url = URLFactory.login.URL
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("", forHTTPHeaderField: "Authorization")
        let data = try? JSONEncoder().encode(user)
        
        let uploadTask = URLSession.shared.uploadTask(with: urlRequest, from: data)  { (data, response , error) in
            guard error == nil else {
                print(error!.localizedDescription)
                showAlert(title: "Login Error", message: error!.localizedDescription)
                return
            }
            guard let aData = data else {return}
            do {
                let userLoginInfo = try JSONDecoder().decode(UserLoginInfo.self, from: aData)
                DispatchQueue.main.async {
                    
                    LoadingView.stop()
                    completedHandler(userLoginInfo)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        uploadTask.resume()
    }
    
    func callAPIHistory(userID: Int,  completedHandler: @escaping(ClientsHistory) -> Void) {
        let url = URL(string: URLFactory.history.URL.absoluteString + "\(userID)")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
        let uploadTask = URLSession.shared.dataTask(with: urlRequest)  { (data, response , error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let aData = data else {return}
            do {
                let jSonObject = try JSONDecoder().decode(ClientsHistory.self, from: aData)
                DispatchQueue.main.async {
                    completedHandler(jSonObject)
                }
            } catch {
                print(error)
            }
        }
        uploadTask.resume()
    }
    
    func getPromotion(pageNumber: Int, completedHandler: @escaping(PromoService) -> Void) {
        
        guard let url = URL(string: URLFactory.promotion.URL.absoluteString + "\(pageNumber)/5") else {
            return
        }
        print(url.absoluteString)
        let urlRequest = URLRequest(url: url)
        
        let downloadTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, _, error) in
            guard error == nil else {return}
            guard let aData = data else {return}
            do {
                
                let promotionData = try JSONDecoder().decode(PromoService.self, from: aData)
                DispatchQueue.main.async {
                    completedHandler(promotionData)
                }
            
            } catch {
                print(error.localizedDescription)
            }
        })
        downloadTask.resume()
    }
}
