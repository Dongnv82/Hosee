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
    let userInfo: UserLoginInfo = (UserDefaults.standard.object(forKey: "userInfo") as? UserLoginInfo)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getHistoryData(id: userInfo.data.client.id)
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.post(name: .toggle, object: nil, userInfo: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyAray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryTableViewCell
        cell.codeLabel.text = "Mã \(historyAray[indexPath.row].id)"
        if historyAray[indexPath.row].service_type == 0 {
            cell.codeLabel.text = "Sửa Camera"
        } else if historyAray[indexPath.row].service_type == 1 {
            cell.codeLabel.text = "Sửa điều hoà"
        } else if historyAray[indexPath.row].service_type == 2 {
            cell.codeLabel.text = "Sửa đèn điện"
        }
        cell.nameLabel.text = historyAray[indexPath.row].partner.display_name ?? ""
        cell.phoneLabel.text = historyAray[indexPath.row].partner.phone_number ?? ""
        cell.addressLabel.text = historyAray[indexPath.row].address
        cell.priceLabel.text = "VND \(historyAray[indexPath.row].charge_amount)"
        cell.starRating.rating = historyAray[indexPath.row].client_rating ?? 0
        return cell
    }
    
    func getHistoryData(id: Int) {
        DataService.shared.callAPIHistory(userID: id) { (historyData) in
            self.historyAray = historyData.data
            self.tableView.reloadData()
        }
    }
    @objc func refreshData() {
        getHistoryData(id: userInfo.data.client.id)
        refreshControl?.endRefreshing()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
