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
    
    
    var historyAray: [ClientsHistory.HistoryData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Bài mẫu CallAPi login, Đức lấy xong xoá luôn hộ anh rồi request merge lại code cho sạch code nhé
        
//        let user = User(phoneNumber: "+84924586555", password: "123456", latitude: 21.0335302, longtitude: 105.7678049, deviceID: UIDevice.current.identifierForVendor!.uuidString)
//
//        DataService.shared.callAPILogin(user: user) { (userData) in
//            UserDefaults.standard.set(UserLoginInfo, forKey: "userInfo")
//        }
        
//        if let userInfo: UserLoginInfo = UserDefaults.standard.object(forKey: "userInfo") as? UserLoginInfo {
            getHistoryData()
//        }
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyAray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryTableViewCell
        cell.codeLabel.text = "Mã \(historyAray[indexPath.row].id)"
        cell.nameLabel.text = historyAray[indexPath.row].partner.display_name ?? ""
        cell.phoneLabel.text = historyAray[indexPath.row].partner.phone_number ?? ""
        cell.addressLabel.text = historyAray[indexPath.row].address
        cell.priceLabel.text = "VND \(historyAray[indexPath.row].charge_amount)"
        cell.taskLabel.text = "Sửa \(historyAray[indexPath.row].service_type)"
        cell.starRating.rating = historyAray[indexPath.row].client_rating ?? 0
        return cell
    }
    
    func getHistoryData() {
        DataService.shared.callAPIHistory(userID: 4) { (historyData) in
            self.historyAray = historyData.data
            self.tableView.reloadData()
        }
    }
    @objc func refreshData() {
        getHistoryData()
        refreshControl?.endRefreshing()
    }
}
