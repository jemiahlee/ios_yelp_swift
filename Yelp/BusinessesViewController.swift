//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var listingTableView: UITableView!

    var businesses: [Business]!
    var searchBar: UISearchBar!
    var filterBarButton: UIBarButtonItem!
    var searchBarButton: UIBarButtonItem!

    let config = YelpConfig.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .Plain, target: self, action: "goToFilterView:")

        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        listingTableView.delegate = self
        listingTableView.dataSource = self
        listingTableView.estimatedRowHeight = 100
        listingTableView.rowHeight = UITableViewAutomaticDimension
    }

    func goToFilterView(sender: UIBarButtonItem?) {
        performSegueWithIdentifier("filterViewSegue", sender: sender)
    }

    override func viewDidAppear(animated: Bool) {
        performSearch()
    }

    func performSearch(){
        Business.searchWithTerm(config.searchTerm, sort: YelpSortMode(rawValue: config.sort), categories: [], deals: config.deals) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.listingTableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListingCell", forIndexPath: indexPath) as! ListingCell
        cell.listing = businesses[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let business = businesses {
            return business.count
        }
        return 0
    }

    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        if searchText.isEmpty {
            performSearch()
        } else {
            config.searchTerm = searchText
            performSearch()
        }
    }
}
