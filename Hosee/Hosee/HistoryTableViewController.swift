//
//  TableViewController.swift
//  KiemTien2
//
//  Created by daicudu on 3/19/19.
//  Copyright © 2019 daicudu. All rights reserved.
//

import  UIKit
import GoogleMaps

class HistoryTableViewController: UITableViewController, UINavigationControllerDelegate {
    
//    var historyAray: [clientsHistory.historyData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 228
        //Bài mẫu CallAPi login, Đức lấy xong xoá luôn hộ anh rồi request merge lại code cho sạch code nhé
        
//        let user = User(phoneNumber: "+84924586555", password: "123456", latitude: 21.0335302, longtitude: 105.7678049, deviceID: UIDevice.current.identifierForVendor!.uuidString)
//
//        DataService.shared.callAPILogin(user: user) { (userData) in
//            UserDefaults.standard.set(UserLoginInfo, forKey: "userInfo")
//        }
        
//        if let userInfo: UserLoginInfo = UserDefaults.standard.object(forKey: "userInfo") as? UserLoginInfo {
            DataService.shared.callAPIHistory(userID: 4) { (historyData) in
//                print(historyData.code)
//                self.historyAray = historyData.data
                print(historyData)
                self.tableView.reloadData()
            }
//        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return historyAray.count
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryTableViewCell
//        cell.codeLabel.text = "\(historyAray[indexPath.row].id)"
//        cell.nameLabel.text = historyAray[indexPath.row].partner.display_name
//        cell.phoneLabel.text = historyAray[indexPath.row].partner.phone_number
//        cell.locationLabel.text = "\(historyAray[indexPath.row].address.dropFirst())"
//        cell.priceLabel.text = "VND \(historyAray[indexPath.row].charge_amount)"
//        cell.taskLabel.text = "Sửa \(historyAray[indexPath.row].service_type)"
//        cell.starRating.rating = historyAray[indexPath.row].client_rating
        return cell
    }
}
