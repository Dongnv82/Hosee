//
//  ViewController.swift
//  HasPromotion
//
//  Created by duycuong on 3/27/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit

class PromotionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var pageNumber = 0
    let pageTotal = 2
    var pageSize = 1
    var countPromo: Int = 0
    
    var message: String?
    
    var dataString: String?
    var dataArrayFromAPI: [PromoData] = []
    var filterData: [PromoData] = []
    var tempArray: [PromoData] = []
    var totalArray: [PromoData] = []
    
    var timer = Timer?.self
    
    let formatter: DateFormatter = {
        let tmpFormatter = DateFormatter()
        tmpFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        return tmpFormatter
    }()
    
    func getTimeOfDate() -> String {
        let curDate = Date()
        let timeString = formatter.string(from: curDate)
        return timeString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        setDataArrayFromAPI(pageNumber: pageNumber)
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        filterData = tempArray
        tableView.reloadData()
    }
    
    
    func loadMore() {
        if countPromo > pageSize {
            if message != "sql: no rows in result set" {
                pageNumber += 1
                setDataArrayFromAPI(pageNumber: pageNumber)
            }
        }
    }
    
    func setDataArrayFromAPI(pageNumber: Int) {
        
        PromotionDataService.shared.getData(pageNumber: pageNumber) { (data) in
            print(data)
            self.countPromo = data.count ?? 0
            self.message = data.mess
            print(self.countPromo)
            
            self.dataArrayFromAPI = data.data
            self.filterData += self.dataArrayFromAPI
            self.totalArray = self.filterData
            
            self.setUpSearchBar()
            self.alterLayout()
            self.tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PromotionTableViewCell else {
            return UITableViewCell()
        }
        let dateTo = filterData[indexPath.row].availableTo?.toDate
        let dateNow = getTimeOfDate().toDate
        
        let dayLeft = Calendar.current.dateComponents([.day], from: dateNow, to: dateTo!)
        
        
        cell.promotionDayLabel.text = String("\(dayLeft.day!) ngày")
        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        cell.titleLabel.text = filterData[indexPath.row].keyString
        cell.timeLabel.text = filterData[indexPath.row].availableTo
        cell.timeLabel.textColor = UIColor.gray
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == filterData.count - 1 {
            loadMore()
        }
    }
    
    
    // MARK: - Method for search
    func searchBarEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchBarEmpty() == true
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    func alterLayout() {
        tableView.tableHeaderView = UIView()
        
        //search bar in navigation bar
        navigationItem.titleView = searchBar
        
        searchBar.showsScopeBar = false
        searchBar.placeholder = "Search by Name"
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filterData = totalArray
            tableView.reloadData()
            return
        }
        tempArray = filterData
        filterData = tempArray.filter({ text -> Bool in
            text.keyString!.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            filterData = dataArrayFromAPI
        default:
            break
        }
        tableView.reloadData()
    }
    
}

extension PromotionViewController {
    func convertTime() -> Int {
        let available_from = "2019-01-05T08:00:00Z"
        let available_to = "2019-01-10T17:15:00Z"
        //2018-09-17T12:48:11Z
        //initialize the Date Formatter
        let dateFormatter = DateFormatter()
        
        //specify the date Format
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        //get date from string
        let available_fromString = dateFormatter.date(from: available_from)
        let available_toString = dateFormatter.date(from: available_to)
        let inter = Calendar.current.dateComponents([.day], from: available_fromString!, to: available_toString!)
        //get timestamp from Date
        let fromTime  = available_fromString!.timeIntervalSince1970
        let toTime = available_toString!.timeIntervalSince1970
        print(toTime)
        print(fromTime)
        let date = Date.init(timeIntervalSinceNow: 86400)
        let dateNow = Date()
        print(date)
        print(dateNow)
        print(inter.day!)
        
        return inter.day ?? 0
    }
}





