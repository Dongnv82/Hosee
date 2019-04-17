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
    var pageSize = 3
    var countPromo: Int = 0
    var message: String = ""
    var promotions: [Promo] = []
    
    //    let  searchController = UISearchController(searchResultsController: nil)
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        setDataArrayFromAPI(pageNumber: pageNumber)
        tableView.delegate = self
        
        let searchResultController = UIStoryboard(name: "Promotion", bundle: nil).instantiateViewController(withIdentifier: "PromotionResultController") as! PromotionResultController
        searchController = UISearchController(searchResultsController: searchResultController)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Here"
        definesPresentationContext = true
        searchController.searchBar.tintColor = UIColor.green
        
        //        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    func loadMore() {
        if countPromo >= pageSize {
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
            print("pageNumber = \(pageNumber)")
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
            print("promotions.count = \(promotions.count)")
            loadMore()
        }
    }
    
}


extension PromotionViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        let searchResultController = (searchController.searchResultsController as! PromotionResultController)
        
        searchResultController.promotions = promotions.filter({ text -> Bool in
            text.keyString!.lowercased().contains(searchText.lowercased())
        })
        
        searchResultController.tableView.reloadData()
    }
    
}
