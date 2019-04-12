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


    @IBOutlet weak var tableView: UITableView!
    
    var pageNumber = 0
    var pageSize = 5
    var countPromo: Int = 0
    var message: String = ""
    var promotions: [Promo] = []

//    let  searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        setDataArrayFromAPI(pageNumber: pageNumber)
        tableView.delegate = self
        
//
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Seach Here!!!"
//        navigationItem.searchController = searchController
//        searchController.searchResultsUpdater = self
//        definesPresentationContext = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        DataService.shared.getPromotion(pageNumber: pageNumber) { (promotionService) in
            self.promotions += promotionService.data
            self.countPromo = promotionService.count ?? 0
            self.message = promotionService.message ?? ""
            self.tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promotions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PromotionTableViewCell
        let promotion = promotions[indexPath.row]
        cell.promotion = promotion
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == promotions.count - 1 {
            loadMore()
        }
    }
    
//
//    // MARK: - Method for search
//    func searchBarEmpty() -> Bool {
//        return searchBar.text?.isEmpty ?? true
//    }
//
//    func isFiltering() -> Bool {
//        return searchBarEmpty() == true
//    }
//
//    private func setUpSearchBar() {
//        searchBar.delegate = self
//    }
//
//    func alterLayout() {
//        tableView.tableHeaderView = UIView()
//
//        //search bar in navigation bar
//        navigationItem.titleView = searchBar
//
//        searchBar.showsScopeBar = false
//        searchBar.placeholder = "Search by Name"
//    }
//
////    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
////        guard !searchText.isEmpty else {
////            filterData = totalArray
////            tableView.reloadData()
////            return
////        }
////        tempArray = filterData
////        filterData = tempArray.filter({ text -> Bool in
////            text.keyString!.lowercased().contains(searchText.lowercased())
////        })
////
////        tableView.reloadData()
////    }
////
////    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
////        switch selectedScope {
////        case 0:
////            filterData = dataArrayFromAPI
////        default:
////            break
////        }
////        tableView.reloadData()
////    }
////
}




// MARK: - <#Mark#>

extension PromotionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {return}
        let resultController = searchController.searchResultsController as! PromotionResultController
        
        resultController.promotions = promotions.filter{$0.keyString!.contains(searchText)}
        resultController.tableView.reloadData()
        
    }
    
    
}

